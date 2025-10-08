Return-Path: <linux-arch+bounces-13956-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 107DFBC52EF
	for <lists+linux-arch@lfdr.de>; Wed, 08 Oct 2025 15:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36675401590
	for <lists+linux-arch@lfdr.de>; Wed,  8 Oct 2025 13:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CED283FFC;
	Wed,  8 Oct 2025 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WA3uLfNt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86612848A0
	for <linux-arch@vger.kernel.org>; Wed,  8 Oct 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929880; cv=none; b=hVNsOqXk1ds8/xXgWxadW2OGVex1CCTMcUuQ5AM/nrnbPCntJLCu5T/f1gxM8KtGyecxUX/vIZdoUXmqCUtI/mTWB0W/F5Dv+leagxdNQyoPiSPxnOJDPfXVzOGPsBWSAXpEUz7Sz6f/HqEbE+z06EOeIBy6pvw8YQaRJbi5LQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929880; c=relaxed/simple;
	bh=fHRL68xgbrs4S5d+Rk03mc7ClH8sihNkbqrGqaL31yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i5pt2/PqaDZ+uxsxAhL/Hm0BUBLqnGcs+f9jA5//BaMXBXCKKCLNvW8AjsJdbm10DQ2j2HM2/PbggHYPc5rIA4hTLLq9YrjU8NFNU7whsAG9zT5Fi0QiNfqjR13zYL8qxw3BPOgdHjr+aPTyqibl7RlHnpdd/rj8bJgmasMQSPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WA3uLfNt; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee130237a8so5456819f8f.0
        for <linux-arch@vger.kernel.org>; Wed, 08 Oct 2025 06:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759929876; x=1760534676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ai9bodin2zTCE30sm2MezQ75jr/Y4H7WdWVegLgSDKU=;
        b=WA3uLfNtZKVV9l37I3e/ToYZya1MGuHLUToON1sDJ/mLNk46sz/nZGuPgKgrnftm0t
         HjTiJHGd+b8TbTp8eU2AQrbPTpifE+cM4okUjyzbzXtjNNkWm6TiDG2fgLsoUvQ/543K
         broEnKIROX30s0w4pdscVGlZYdYRs1ZSg0ALpZFhRbFMD5pBMpXgG2xDETEN3s9rO52P
         ayBhwuPWIMGvmWTxzTuBPYmkuQ2YObGPFr4YCWt9S8aNBtJidU7quF6COOIeSrPQJL+4
         GPMcCr1hYobFqLfwpJzqZgyj7dW9HM4M0VnjpYnYXk0fMfT7zTnKLKA8qQhdicB8t71T
         gNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929876; x=1760534676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ai9bodin2zTCE30sm2MezQ75jr/Y4H7WdWVegLgSDKU=;
        b=NsY8Dz81+XebLKkBHPUoBCFtTb9WWUp1ah/TDj0tKGWnq3v8wAm42rF1BfYtB4wXLl
         ruWhnCbtr/pTrrZSgO25UR8CGcyYE0Ic0OvaTBtlf8YXG5SyOMxS7JxYgisDmoHo/KIa
         SoD1tNJugqdviG8lxf8FrvHbXFeY0V2/O4Mf5vuu2oI38pAVbTuQGdFC06k8pO7HyOUe
         bkB26T3wdc60Fngp8VIvpVvHAzn0FWIWpybz6np0PgJWFldJu1Z2/67WQ4h7YiZ/xsQu
         zkTVoLRi5YgHeVXiwmUEkbFmeelTRiKulTaVVy020Wm0iryEmk3OxS1uxwhJPnNRnCnH
         pfcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUhycCGuLjPhEa9Lhg95dlVDWm5RlLswHU+Y1mM0R1hUNy0SP+ptkAdYBIQE33ny+cSI8FKpw4ICpK@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv8l5khIRr4zMQiZVwJ9hNpt+fbpDDS4+Niq0+McoCazkYnRoL
	QzY5oufqViVOfDTaX49W0SUR4RnS31eD12bX3TPb4m7U0lpPMquIB/K1nsfz6mL3R34N9wT6KAY
	w0CIP
X-Gm-Gg: ASbGncuGLTKmv+QSzzVBAXoAy8aDz5yZH+R0pxLdgyiM4y+PDHW6PhfJp3XcO9ZUtDy
	fuJ7hp7Ql3AJgQWobzA74+b4Co3Ls138EMy26h4VhdLZ8AJOd+MxyeNCh+g7Rhar0FZ6Pcg0kJg
	r1oipjZCArr0xEEADUkSX1hh8l1vlvKqWdNxnZ1IuPX+03URoUoqnVQM86lKLvTiTF1IauHeGFD
	WOZWuIETqYlDz88KXsAFAtxLY1zFeI86J6Eq43FRiKeARB+4/I3EnIL1iAH4NKemPHU255PE237
	977Kn6nzYU7yBhY+IyU1YGIAWVz6IW2RJU9S42wibdniBaxNmqYULtfocJ/KdKumuRvHBv93iGU
	gp3j+XDfbu5rKgchs57VwRy7RI2nrwrzkA2R5ABN/Gt4NK7zqlA1X0mXg1pI6rBIc
X-Google-Smtp-Source: AGHT+IHuhMKyjw9ZbS23OBrv8VA5JUlHXtFCz8Wrw4kfUqnmq3pfnc8RuPQ01+3mL+le3/TLouPIeg==
X-Received: by 2002:a05:6000:22c7:b0:3ec:6259:5079 with SMTP id ffacd0b85a97d-42666ab1b7fmr2477434f8f.11.1759929876072;
        Wed, 08 Oct 2025 06:24:36 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab8b0sm29892836f8f.18.2025.10.08.06.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 06:24:35 -0700 (PDT)
Message-ID: <b394956c-5973-438b-9e43-f7081a89fa97@suse.com>
Date: Wed, 8 Oct 2025 15:24:35 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] remove references to *_gpl sections in
 documentation
To: Siddharth Nayyar <sidnayyar@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Nicolas Schier <nicolas.schier@linux.dev>,
 Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250829105418.3053274-1-sidnayyar@google.com>
 <20250829105418.3053274-9-sidnayyar@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250829105418.3053274-9-sidnayyar@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 12:54 PM, Siddharth Nayyar wrote:
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
> ---
>  Documentation/kbuild/modules.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
> index d0703605bfa4..f2022fa2342f 100644
> --- a/Documentation/kbuild/modules.rst
> +++ b/Documentation/kbuild/modules.rst
> @@ -426,11 +426,11 @@ Symbols From the Kernel (vmlinux + modules)
>  Version Information Formats
>  ---------------------------
>  
> -	Exported symbols have information stored in __ksymtab or __ksymtab_gpl
> -	sections. Symbol names and namespaces are stored in __ksymtab_strings,
> +	Exported symbols have information stored in the __ksymtab section.
> +	Symbol names and namespaces are stored in __ksymtab_strings section,
>  	using a format similar to the string table used for ELF. If
>  	CONFIG_MODVERSIONS is enabled, the CRCs corresponding to exported
> -	symbols will be added to the __kcrctab or __kcrctab_gpl.
> +	symbols will be added to the __kcrctab section.
>  
>  	If CONFIG_BASIC_MODVERSIONS is enabled (default with
>  	CONFIG_MODVERSIONS), imported symbols will have their symbol name and

Nit: I realize this part of the document primarily discusses sections
related to modversions, but I think it would be good to briefly mention
also the existence of the __kflagstab section. The first sentence could
say:

Exported symbols have information stored in the __ksymtab and
__kflagstab sections.

-- 
Thanks,
Petr

