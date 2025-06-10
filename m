Return-Path: <linux-arch+bounces-12310-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A877EAD3903
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 15:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22B4E7B1BF2
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 13:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A3729AB1C;
	Tue, 10 Jun 2025 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="y9daLEYn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C798C224AF2
	for <linux-arch@vger.kernel.org>; Tue, 10 Jun 2025 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561584; cv=none; b=FqUeKaKSJZcv3hUdKEQ0mUh5anbSWAIngJsGhVyPj/dokCa/SSeVYU2Iit9T5s0DjBLD5K6wYzcf135IGcXledXSmkOH2dMykDYMuNPZh6vevxlMcr03bM/a8edztLCcl5pnxqzQRhHHyXtGblUbG0sLKZHC3PqO7yON6kkytck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561584; c=relaxed/simple;
	bh=Jsox4AqmuF0T2eC0/6nvbkiWzIT0wulj3TrnpMEznbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zf1npwj33V2l2gWGBt4tc5RyNtdr3/ia1YyH4e3VdIcUrqV8AZUBKjM8EB/bhQBwh+U4e3Kje3OA6WmLr5KF/HArDg2EeoOWOBTrPBMdE/liFinGHJpSa0wDfMfabEqB/pcYr4n+sPui+CdrZvRvKJcs6FLs+nRgLhPwLFZ1S4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu; spf=none smtp.mailfrom=monstr.eu; dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b=y9daLEYn; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=monstr.eu
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-606ddbda275so10024798a12.1
        for <linux-arch@vger.kernel.org>; Tue, 10 Jun 2025 06:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1749561579; x=1750166379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VIDU90Ie38fuojjens1gbZ5zc8b8xPeZNLiJttT95T8=;
        b=y9daLEYnpUPrAhadRt/z3MtezGP+VQuzDNw/UVdUWwR3SRQrSYJgP8IF7DEmVwvxXR
         SRAiBuKkoj80vVgDDpHftL7757QjwPiCirMMcW6VYu1XrnxYZW9c5zfQI2nmK+f37YUa
         VI6PCl7gKuzt1DqjafemiCKqRv7gy9gWixJitxChMbu6K6cWRAUZTiEd2j4tZ/33OwxO
         NhO73jiktOfU90JUZp0lWfdtioQmTldw26DpEB9Ico8gdY5Anuf/g/MrPbbnsreMKGFA
         6fCTcdasldf+QSeRgqlhrFirTTJcwsyROJE688JNJDCyMtem1oPNPMIjJdHow8jAHtVo
         qKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749561579; x=1750166379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VIDU90Ie38fuojjens1gbZ5zc8b8xPeZNLiJttT95T8=;
        b=qrCKYFQ6cb/V335yYkPx2MQofAlpkFWWnw/JuxBAmhP4nWkxqI2xks5WgprrJgEjho
         Y70+hb9TowPNPCPR1/YU0o0bQP5aswVAmhRWNlpFqoJWa2SrCK2lvL1yWwXbz51A5MVI
         i96ZgjKiH8QOMBcItAKP+n19CqD6tjHeO6rjqKzluJgVA/zZWo+r9nZz9ZIH4jD/xaC+
         mNt0fOiRkWWRoQXDIO/sbl64rsUGD6pyNk6Zo+oCWyQgZIVCqAkCt6/25ltETEx56qw0
         1SAIKOdqULkjJzzS0bxusiYOLzadaHnvaKY3XF6wx0/LwyD7rPiETXe2VuxUHmnJfEod
         8eMA==
X-Forwarded-Encrypted: i=1; AJvYcCXRN5IpVJ7aIBZsI+nlWW+C7FSvXwGzzxyjz/RzZuC9nMQdfkjeFuYvGD/cFep0njsxdsw1e0QCeOE4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt5xsl8g8hKai9J3V8Hh9t8Tz7Y06/3kKWG2EBcV2ZzoGfY4VE
	H3Oh9DcKFNhfQW5szEJ7EYlrESW+dR/+b8I44UsLgo7znlnpeZZkVf+tPHPeuFcsiw==
X-Gm-Gg: ASbGncvRGOzL1OtFfK8CgR64ENY8xs8nX/GkKjxSDFjZzyJgzLRO8TdTuK8yXF8qFX2
	zez8kmB7G9LoKlFjI+MC+2q3ndfQhTTnPG+BthnNjUAeObXA4ri3xuf36cbvkVUwjAs7/qqUfUp
	AkomOZdM5rttfpQDKIBRhX+bH0yq/xVSRHZf9qEatQUlNIQJTCRcbKyd1qa+TbyHigv9MXviyLW
	GF7bgcH6tX2LaLe2lrS2SBoEMaCAF9s3fctJl0J7jo+BSZiJVzjCdhy2O6RAZvpiqgfxZ97Jrui
	BGXY0+BLJ4H+EdKYatNp+WqZlzLquIeCFPTJwkrR9ERUF0Jcn9xymlxwLIqGfIeLo3b6O5QNw5+
	khih+
X-Google-Smtp-Source: AGHT+IG/cCzTcGiirGBsHHHWeDKwdsnsEz2/ln/aWRJ/eCbaXghL1SbCEuAcFeYlYWL4UWTOVK/saw==
X-Received: by 2002:a17:907:1ca3:b0:ad8:9778:4e51 with SMTP id a640c23a62f3a-ade1a978b6cmr1508784666b.30.1749561578630;
        Tue, 10 Jun 2025 06:19:38 -0700 (PDT)
Received: from [192.168.0.105] (nat-108.starnet.cz. [178.255.168.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc7d2d8sm724943666b.180.2025.06.10.06.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 06:19:38 -0700 (PDT)
Message-ID: <2d365f8e-de15-4321-bc69-e83721e5e7b4@monstr.eu>
Date: Tue, 10 Jun 2025 15:19:37 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/41] microblaze: Replace __ASSEMBLY__ with __ASSEMBLER__
 in uapi headers
To: Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-18-thuth@redhat.com>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <20250314071013.1575167-18-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/14/25 08:09, Thomas Huth wrote:
> __ASSEMBLY__ is only defined by the Makefile of the kernel, so
> this is not really useful for uapi headers (unless the userspace
> Makefile defines it, too). Let's switch to __ASSEMBLER__ which
> gets set automatically by the compiler when compiling assembly
> code.
> 
> This is a completely mechanical patch (done with a simple "sed -i"
> statement).
> 
> Cc: Michal Simek <monstr@monstr.eu>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   arch/microblaze/include/uapi/asm/ptrace.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/microblaze/include/uapi/asm/ptrace.h b/arch/microblaze/include/uapi/asm/ptrace.h
> index 46dd94cb78021..8039957a1a9cd 100644
> --- a/arch/microblaze/include/uapi/asm/ptrace.h
> +++ b/arch/microblaze/include/uapi/asm/ptrace.h
> @@ -10,7 +10,7 @@
>   #ifndef _UAPI_ASM_MICROBLAZE_PTRACE_H
>   #define _UAPI_ASM_MICROBLAZE_PTRACE_H
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   typedef unsigned long microblaze_reg_t;
>   
> @@ -68,6 +68,6 @@ struct pt_regs {
>   
>   #endif /* __KERNEL */
>   
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>   
>   #endif /* _UAPI_ASM_MICROBLAZE_PTRACE_H */

Applied.
M


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs



