Return-Path: <linux-arch+bounces-12355-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68339ADC656
	for <lists+linux-arch@lfdr.de>; Tue, 17 Jun 2025 11:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3242A17996B
	for <lists+linux-arch@lfdr.de>; Tue, 17 Jun 2025 09:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF5E293C62;
	Tue, 17 Jun 2025 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HfaFhXWh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4901293B7E
	for <linux-arch@vger.kernel.org>; Tue, 17 Jun 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152464; cv=none; b=tHNmQDjNOrUSd9+6JfUVsW017RxD+J+2zQby8xFBZq+IrizpNA3vmuOW2DSNknSRPqny747JgHMivn+1jaqrRQpDuJr0qGuNMO9r3BhyxfXKsHSuyluVbX7FQJGW2BZM4NDOaxEYllDp/MTCyxVXalWONAjyo2j1x96TU1YZx+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152464; c=relaxed/simple;
	bh=f3FXbCp1zJT2e/y37zile6+NsyCTyyggM8rYqlTqvGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRkDxHvOI2e+gNIVljQxMFL0sMiPAYmc+halKXadEdH5xLAcEXoch9ySlTzdUIqyNw5Mba4Z9gXyRne3hVCucTCMzdI6+SloaSPH9zmO20voZ308p5jtcSv5k9v1cbJWRe4cOJ54aER+ly+J0vBVMWsFvbPhoa5nsjOwXv4VtQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HfaFhXWh; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3a365a6804eso3971756f8f.3
        for <linux-arch@vger.kernel.org>; Tue, 17 Jun 2025 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750152460; x=1750757260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=boN3t4QQQ5CJaq9F2B9aIVemxFll5K0ZGpv67UpOwpI=;
        b=HfaFhXWhDA6c/ysVVOaYkIshY6amQ6jMyyRlRTgXilO33yD0L5Gwt70j+8+S5hy7f9
         FCKkZrirayOh2DCyT5oll6krNLYGAIBPl5gpc7bSxOdkIYntMGrmw2ioqWPswjXk2kRB
         LpfJv/Cn1f4Uk8SNPEok7e3hzUVmeND3FP5mawsihpE9f3GiwOAw22ENxnCWtWoZGS/8
         of/6VYb+E8tKheFtFsy0XOXrvHLfuusuv7+we0mqDAPMtekgoAaUVUNuGNDzHGR4rMHt
         CKC9mMRca3gsL1G88cpDB9JHJxl1v6ve/WpzGqDFruJVLqUlg7OqrnnK9R5S0L5P4SU7
         FXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750152460; x=1750757260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boN3t4QQQ5CJaq9F2B9aIVemxFll5K0ZGpv67UpOwpI=;
        b=E3q+FU2WfLBVkB29b4bwLCjIC40YxfgxNF25SbSFjhsnk4fnfrcBDeYtXh1a2qjyNi
         mVQtl8Jj7plcElQGU6ZTeJrb7Gcx7i0QD5TGaAmDabFN+KR40vyOt6eLn5/xk9sdaCy5
         tPlz0lZXIPae1UsUqST/C69OB53wbJXMwpo85yB1u8Ceeu8z+nEtdtVAj0NRESX4hsFC
         UF67VMR04V3SpRvA40RnmVc5RE3ioV1DoRroYYH9/jf4tp6tikpwXW3RgiTIeCG5bKZJ
         vI1DmRK+2OPGea3X0r1JdP9+IbCwgtsZGEGbCuhgZGXBfES7qprqzfxiZDBHhKZOhdt3
         uu0A==
X-Forwarded-Encrypted: i=1; AJvYcCWV9FYNFI2ZB8Eh+Ji7u4hTv3DebVdvuZvCG1B+RC6wwRegFud84vW6dare0+oK8lqq4giK/2JyL8Zu@vger.kernel.org
X-Gm-Message-State: AOJu0YxCqfk4wROlFbS2CdY3enhpD8O1Ax3KHbTuarDHFwpPZVesfwqy
	9bhOue6oC7n2Qw1vfe1IvWbTy7RctA3pnV8QuiHswA2PnraEad+v1uBvr3Q5/gdOYL4=
X-Gm-Gg: ASbGnctFZ+x2IwbwXx1V0de0k/wX5h12ax6freoDti+gctDE/PVSTkwWEKJKwV4NNpy
	DsFGDcL+7L2+7Cpk4rJGxViy7jbXql193bZoQlkwF9qSR0qMBjEMaZHjdDnetba+O4aGA3gzgRk
	0OOuYrtWu52eOMfCu5ofrlWKIMkPDvmawIvbkd2T3pn3hBOLjxm3xJRVdsorLbw8MJ3nlOZ9KWd
	UHoJXD85JPE6MdojDAwP0FfNwxXMNHyhF5kyrSDtHimithcmGGt00+TFXVSKsRxLmjWBSQDsmhf
	1SkUJjdHOUNOwhI6WdmDp+dXjtYrww6WIh0lw2Dg9EZ7utUt5fxnw8Y3qLEoY0xyBg==
X-Google-Smtp-Source: AGHT+IFM9Lj5qJWTtP6+l5n+/04TRA1i4YBOucx2CbKedvvZJIa35JF0Mqa14giJEb7sodnjrvIhwA==
X-Received: by 2002:a05:6000:708:b0:3a5:5278:e635 with SMTP id ffacd0b85a97d-3a572367577mr9469207f8f.3.1750152460099;
        Tue, 17 Jun 2025 02:27:40 -0700 (PDT)
Received: from [10.100.51.209] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b18f96sm13555006f8f.66.2025.06.17.02.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 02:27:39 -0700 (PDT)
Message-ID: <2cd3947a-63d9-4a79-a24a-eb1ae8164169@suse.com>
Date: Tue, 17 Jun 2025 11:27:39 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] alloc_tag: remove empty module tag section
To: Casey Chen <cachen@purestorage.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-arch@vger.kernel.org, surenb@google.com, kent.overstreet@linux.dev,
 arnd@arndb.de, mcgrof@kernel.org, pasha.tatashin@soleen.com,
 yzhong@purestorage.com
References: <20250610162258.324645-1-cachen@purestorage.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250610162258.324645-1-cachen@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/25 6:22 PM, Casey Chen wrote:
> The empty MOD_CODETAG_SECTIONS() macro added an incomplete .data
> section in module linker script, which caused symbol lookup tools
> like gdb to misinterpret symbol addresses e.g., __ib_process_cq
> incorrectly mapping to unrelated functions like below.
> 
>   (gdb) disas __ib_process_cq
>   Dump of assembler code for function trace_event_fields_cq_schedule:
> 
> Removing the empty section restores proper symbol resolution and
> layout, ensuring .data placement behaves as expected.

The patch looks ok me, but I'm somewhat confused about the problem.
I think a linker should not add an empty output section if it doesn't
contain anything, or if .data actually contains something then the extra
dummy definition should be also harmless?

This also reminds me of my previous related fix "codetag: Avoid unused
alloc_tags sections/symbols" [1] which fell through the cracks. I can
rebase it on top of this patch.

[1] https://lore.kernel.org/all/20250313143002.9118-1-petr.pavlu@suse.com/

-- 
Thanks,
Petr

