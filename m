Return-Path: <linux-arch+bounces-13957-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8720ABC53B7
	for <lists+linux-arch@lfdr.de>; Wed, 08 Oct 2025 15:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868E319E101B
	for <lists+linux-arch@lfdr.de>; Wed,  8 Oct 2025 13:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7C42857FA;
	Wed,  8 Oct 2025 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dywjDn0h"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7705328507E
	for <linux-arch@vger.kernel.org>; Wed,  8 Oct 2025 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930536; cv=none; b=TBbmUAP2pakW0DkK9HIoOCBXdboBi8Ky/y2LVviHgGqC1rEhWVgFid4ITrUS400sO/ihREtrk3Rv4zFQKakqKTFGS1M8GHybJdCwRBnPhQPSa54ZtsfghWRfd8C4ijVe9bUp76LrZCL5njZyLILZih0VuIfK1aLjKJ1eA8w7w9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930536; c=relaxed/simple;
	bh=7vGH8N/m6PE6lnr/uLWOIY85RQ6MjHgDYrjIeFb+YNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDGTF6RCbSZrJ0Imaa1rOPzMsMSxRcORu0xzosbUFoE8q/EJ/dNLLfKQP90bT4vFOuJBkQMyvVS4OvgBc/kMIFPG/4ab0IE7VkXQzfQTaHXQ6xQGnE8CU58VGXiQbFgr8cwf8JomLpDNixbjocDQxmEGiV6NhPOU+qqsWWl8UgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dywjDn0h; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e3af7889fso45618425e9.2
        for <linux-arch@vger.kernel.org>; Wed, 08 Oct 2025 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759930532; x=1760535332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDHlNMCgPWfKcx9mEMfAa7rnZ2ePjEXMkf1KPca5jNs=;
        b=dywjDn0hZVcYnCqsGOJwB9zIwhAuPBx6/MnaRssTC2JfxFetIhJNqVQHO9Glfw/Mzl
         jdCKVnXimtkCw+nFxD3dFnOx4hTdnFv3SbJ5xkAh87EiDw6ziOab7IrwKFiDG1dvfCNd
         zBYEFhKO89Acm6ztRue/IbFMpeXzKHV5zH5R+BhNi/y0az0Q0aLDXYMhdJKVuVLQsclY
         yZcjxPi+91EiGK8WBuDigRSxaFesJlkjC1nKNfND+ejLHMimqJvAFU/kRvEiRA7THLqA
         odnmDDe3Drz2vcYt5g/ZyOvD3MWFevAngP95s6KBpFuSxrjXluGXf9FpghAzLon+0V8D
         T86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759930532; x=1760535332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDHlNMCgPWfKcx9mEMfAa7rnZ2ePjEXMkf1KPca5jNs=;
        b=DO8T/5UdifqlP9zGvtavWe2k/MYpfrkqgkPpDpC/QGf6kKCwOQg69rIHOoHNd+C4KS
         qfapxh8W9LFL1rpBhuieAULdO5/viVpSi3dY0SycTY+HKwpJeIxBXDrbv1L7KXS6taS/
         96+BdM0abOWBCvk+uNoDF+czoalxG0DQe/+oGt8rPuH7B3LtqcmN6DKgR93++QCrm2Bp
         BUi0jJeKGQAVLQuji7pmWAJcTEYtcXvKoN64XRLR2bnAfvPh+qaxengFWo19DZ7TE9cr
         uYcTf5TDHb4tsNjnNnQCSA+0KnSR9+hx3Fxgh/vS17faSg4VFx3psDqpU9qN1YCNf/PE
         8QPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOf5Ub+cH7WrTUdpmQZcYdTShXNErqVG8wKueq2pQ6e0jh8EcqAUwERLIdcbuoybIrjvpDt7Mx4Gg6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7KazKH/EKp4ltaaalocIL21jyzs5iGs96y/GJuB5Cq0T/mudu
	gNPBHkccpT5IeJGgq1pSdFyF3sgL8mEnKuJNStfCtRU5yZrlJo/fYfXitFUdyZ2wLzc=
X-Gm-Gg: ASbGncvbN4y7gBF/HhkZdvaKM+dl8tWnrMVtehMGuSxYlPkgLGpDj3GgTBwGaVQD3zs
	px2hI1lgf9OhUqodbWLYN+oTNhJjMCOStLHILAgn2CUbVF1ZAG1C4Ji/WWTwdA1TN0eZ1MAU300
	oKTWPkV5QqKgovetpKKyJNxTqU9Qa009q5A84cL1yQn0oZ0dspauAd1TfozC5p/iEgRTiQTK7GY
	b0rHh1OwEUw34qu93CC8MW87AQFHk8sF5AAhvQG9RZlPFh4/ok0KIlEq42I659zXDAr+Seq3S8Z
	lXis5Fd+OLVul4CG5ofcZbqk3hNm8T6TXMOpKaGo6agw9Y/+FcMt1fLxgK5FO5+qjbsza+W2x53
	tUwDRewNTf25DdmHuCEAnLE9JHaIUSIw63bC5t1TnCq3bE5QCwGbV3h6PNd7qvJn6
X-Google-Smtp-Source: AGHT+IEXN1OK+uUWcZYHcu8mGQCE4xlOe4D5UqEffJSE6zNfCHiuL17ImKFC3KKJ16P8hPWOZxwfnw==
X-Received: by 2002:a05:600c:4f92:b0:458:c094:8ba5 with SMTP id 5b1f17b1804b1-46fa9a96588mr24061795e9.12.1759930531814;
        Wed, 08 Oct 2025 06:35:31 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9762sm30365608f8f.38.2025.10.08.06.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 06:35:31 -0700 (PDT)
Message-ID: <6e057525-ca8d-4f96-bb52-cca6cafbe835@suse.com>
Date: Wed, 8 Oct 2025 15:35:30 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] modpost: add symbol import protection flag to
 kflagstab
To: Siddharth Nayyar <sidnayyar@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Nicolas Schier <nicolas.schier@linux.dev>,
 Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250829105418.3053274-1-sidnayyar@google.com>
 <20250829105418.3053274-10-sidnayyar@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250829105418.3053274-10-sidnayyar@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 12:54 PM, Siddharth Nayyar wrote:
> When the unused exports whitelist is provided, the symbol protection bit
> is set for symbols not present in the unused exports whitelist.
> 
> The flag will be used in the following commit to prevent unsigned
> modules from the using symbols other than those explicitly declared by
> the such modules ahead of time.
> 
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
> ---
> [...]
> diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
> index 574609aced99..96fe3f4d7424 100644
> --- a/include/linux/module_symbol.h
> +++ b/include/linux/module_symbol.h
> @@ -3,8 +3,9 @@
>  #define _LINUX_MODULE_SYMBOL_H
>  
>  /* Kernel symbol flags bitset. */
> -enum ksym_flags {
> +enum symbol_flags {
>  	KSYM_FLAG_GPL_ONLY	= 1 << 0,
> +	KSYM_FLAG_PROTECTED	= 1 << 1,
>  };
>  

Nit: The ksym_flags enum is added in patch #1. If you prefer a different
name, you can change it in that patch.

-- 
Thanks,
Petr

