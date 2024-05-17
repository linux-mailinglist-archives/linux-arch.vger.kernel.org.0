Return-Path: <linux-arch+bounces-4458-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA738C8786
	for <lists+linux-arch@lfdr.de>; Fri, 17 May 2024 15:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46D56B21926
	for <lists+linux-arch@lfdr.de>; Fri, 17 May 2024 13:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3930657319;
	Fri, 17 May 2024 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqciInBf"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F71D46B9A
	for <linux-arch@vger.kernel.org>; Fri, 17 May 2024 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715954083; cv=none; b=IwNHFe1vMQlyBIjnpQwTuDosyeoxAVsaObp7xM3e9+QUraS5TDioQrz2M2EzTccyJUXLLkGbr2E8nc2KK2CDm7C8Qj8ybwlzSQyKALgZrjjcYKYl6nQnhvOEAxiCHaxAkZO8+OGI0DOc5zZFe97hIP5njN6e3YGOYTiUUgVMbv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715954083; c=relaxed/simple;
	bh=PboiBS4ZzUdLaUHPHA2orxrOnIuUIXb03qsrzol/Lpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEyHSiaI3kbxawdp8vG7rUn/qcR6KimaTU3dJnZWn2r41j/KEcP4cs/tXBYQSsdEHAPmiv3Ygq+OI6WddOk1wI5fhwI1e4v/JfkOU8hy1f2pXwdXoPdbg5PmWICjFjX01fOPDv4GrNN+DFmHZvgYKnB3+fSbrEl2xldmd/kiYp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqciInBf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715954079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckgzF/gF0LVkJPIHaMi6FsUAJKsbsEhiiso6m6KhFLY=;
	b=FqciInBfECmndZ1+u6oABqdWo0Bd+IWXLMsHkU5LcTbnD3uGwMYyrRWFxww22zUPowYF96
	58bTT7pqs5klw0js6L9fdI5u8oBIDWZES/16652BCXIJ3+L+/tRfeWpAIUpKFmkR/4GiwI
	DQRnfbDIzlTOgs7XpCvnkkxrUfLoefg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-CxEbYjJkNWyXAWHq-P3DVQ-1; Fri, 17 May 2024 09:54:38 -0400
X-MC-Unique: CxEbYjJkNWyXAWHq-P3DVQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a5a1b50d45cso543523666b.2
        for <linux-arch@vger.kernel.org>; Fri, 17 May 2024 06:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715954077; x=1716558877;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckgzF/gF0LVkJPIHaMi6FsUAJKsbsEhiiso6m6KhFLY=;
        b=MKVhIGg08rjsk0TKKVBNAp5mgVPSrrOoBm1l6YsYcpgGal+uh73kWSI71C6wXXnVIY
         lM4OwdmrCmgGrvvfJ73AOUuzASED7wf38oBscgJgAS6HH0mYQ3T0Vs11UnnejA9dpUM0
         WtQvDU9HINwVihB34PdfYIGOSWsr8BDVk8Y9K4pKtaDxaAokUJ6c88nyL43Gg2tCzUTG
         kmFjusN++O8BL5HZZL3mzKcv0fywTPoVIQoHz+0eCjdZ7uWvPjvK1Fuk8PzavyrGvvA4
         8P0rp4ksRhcA3/66uVWhtwW6KAFnmh0wLzE4XNJtOPSV9yeXkCDu9RQsR4MntUhD1yb1
         39pw==
X-Gm-Message-State: AOJu0YxaTzbzMTseVuGXZ612+4lYBnweT1nhfgFPyzSo56pce3Y769RN
	6gt/fx10ckvUNldI16Uft+sqpoouiPpdGlc51FO0yAIEX5C8+QxUfBEoOUJcX6rjVk350P9+/Rb
	v2bAsC+kxOYFgQFYpfNRzdJGH7rRvvjKgrBYrq6Puy3KupgWSoX2pf5ql8b8=
X-Received: by 2002:a17:906:ae45:b0:a59:c208:a4c with SMTP id a640c23a62f3a-a5a2d583d60mr1357056266b.17.1715954076898;
        Fri, 17 May 2024 06:54:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfJJCDx/mcZGpVUvsHhPUh6z3RkyZXkBJ3RqvMnfIOyn/dCG2D89v/HagZxG/or5jXzYtY3Q==
X-Received: by 2002:a17:906:ae45:b0:a59:c208:a4c with SMTP id a640c23a62f3a-a5a2d583d60mr1357053966b.17.1715954076330;
        Fri, 17 May 2024 06:54:36 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17cd0sm1114128366b.214.2024.05.17.06.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 06:54:35 -0700 (PDT)
Message-ID: <d074cf56-c7e4-41ba-9e8e-931a5d350578@redhat.com>
Date: Fri, 17 May 2024 15:54:35 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch: Fix name collision with ACPI's video.o
To: Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de,
 chaitanya.kumar.borah@intel.com, suresh.kumar.kurmi@intel.com,
 jani.saarinen@intel.com, davem@davemloft.net, andreas@gaisler.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org
Cc: linux-arch@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240517091557.25800-1-tzimmermann@suse.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240517091557.25800-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/17/24 11:14 AM, Thomas Zimmermann wrote:
> Commit 2fd001cd3600 ("arch: Rename fbdev header and source files")
> renames the video source files under arch/ such that they do not
> refer to fbdev any longer. The new files named video.o conflict with
> ACPI's video.ko module. Modprobing the ACPI module can then fail with
> warnings about missing symbols, as shown below.
> 
>   (i915_selftest:1107) igt_kmod-WARNING: i915: Unknown symbol acpi_video_unregister (err -2)
>   (i915_selftest:1107) igt_kmod-WARNING: i915: Unknown symbol acpi_video_register_backlight (err -2)
>   (i915_selftest:1107) igt_kmod-WARNING: i915: Unknown symbol __acpi_video_get_backlight_type (err -2)
>   (i915_selftest:1107) igt_kmod-WARNING: i915: Unknown symbol acpi_video_register (err -2)
> 
> Fix the issue by renaming the architecture's video.o to video-common.o.
> 
> Reported-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Closes: https://lore.kernel.org/intel-gfx/9dcac6e9-a3bf-4ace-bbdc-f697f767f9e0@suse.de/T/#t
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 2fd001cd3600 ("arch: Rename fbdev header and source files")
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  arch/sparc/video/Makefile                    | 2 +-
>  arch/sparc/video/{video.c => video-common.c} | 0
>  arch/x86/video/Makefile                      | 2 +-
>  arch/x86/video/{video.c => video-common.c}   | 0
>  4 files changed, 2 insertions(+), 2 deletions(-)
>  rename arch/sparc/video/{video.c => video-common.c} (100%)
>  rename arch/x86/video/{video.c => video-common.c} (100%)
> 
> diff --git a/arch/sparc/video/Makefile b/arch/sparc/video/Makefile
> index fdf83a408d750..dcfbe7a5912c0 100644
> --- a/arch/sparc/video/Makefile
> +++ b/arch/sparc/video/Makefile
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  
> -obj-y	+= video.o
> +obj-y	+= video-common.o
> diff --git a/arch/sparc/video/video.c b/arch/sparc/video/video-common.c
> similarity index 100%
> rename from arch/sparc/video/video.c
> rename to arch/sparc/video/video-common.c
> diff --git a/arch/x86/video/Makefile b/arch/x86/video/Makefile
> index fdf83a408d750..dcfbe7a5912c0 100644
> --- a/arch/x86/video/Makefile
> +++ b/arch/x86/video/Makefile
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  
> -obj-y	+= video.o
> +obj-y	+= video-common.o
> diff --git a/arch/x86/video/video.c b/arch/x86/video/video-common.c
> similarity index 100%
> rename from arch/x86/video/video.c
> rename to arch/x86/video/video-common.c


