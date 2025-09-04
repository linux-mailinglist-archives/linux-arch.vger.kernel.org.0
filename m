Return-Path: <linux-arch+bounces-13380-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A08B43E29
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 16:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87112A069B8
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 14:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92DF306D54;
	Thu,  4 Sep 2025 14:07:28 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from einhorn-mail-out.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1EF3090EA
	for <linux-arch@vger.kernel.org>; Thu,  4 Sep 2025 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.109.42.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994848; cv=none; b=t2hneD/F1OXZ6B6QhA5z3t/43EWTWyxfAptpSrQn/P7hMsyn158+diiHbK78ZYSCOy8axbxZbXFa8DcbwXZIG/0+FvgwAND3r0OeB8dhNXz1GYIES8YNDNj82csedsQ6KGahiFBbzMoiGkG5xQqbpYYQI0Jm3o6X3eOXhGyGH98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994848; c=relaxed/simple;
	bh=KgBFjeu9szUATId/Aod52mo/ZvN3jtzh4mqqMKXz0x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eo2Lv2XLlJzUlVJyQLpBMo18envX7f6bbLp1CdI/CVVVQcH7sC3oWcaPb9RrtPwhKBlpMutw44hW5H8ttg+Jjq9w3tqGIHVIU6SZvp5SwtH+3BuVNF+LJv0H8jNPaEXKuYWmi7dbzQMTm0XMZEn04uw+Dm5ifb17KMXggRz5Bds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=192.109.42.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
X-Envelope-From: doko@debian.org
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id 584E2hg13579742
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 4 Sep 2025 16:02:43 +0200
Message-ID: <b3db475e-e84d-4056-9420-bc0acc8b9fe5@debian.org>
Date: Thu, 4 Sep 2025 16:02:42 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Don't create sframes during build
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor
 <nathan@kernel.org>,
        Nicolas Schier <nicolas.schier@linux.dev>,
        Binutils <binutils@sourceware.org>
References: <20250904131835.sfcG19NV@linutronix.de>
Content-Language: en-US
From: Matthias Klose <doko@debian.org>
In-Reply-To: <20250904131835.sfcG19NV@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[ CCing binutils@sourceware.org ]

On 9/4/25 15:18, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> gcc in Debian, starting with 15.2.0-2, 14.3.0-6 enables sframe
> generation. Unless options like -ffreestanding are passed. Since this
> isn't done, there are a few warnings during compile

If there are other options when sframe shouldn't be enabled, please tell.

Gentoo chose another approach, enabling sframe unconditionally in gas, 
unless disabled by --gsframe=no.

> | crypto/chacha.o: warning: objtool: .sframe+0x30: data relocation to !ENDBR: chacha_stream_xor+0x0
> | crypto/chacha.o: warning: objtool: .sframe+0x94: data relocation to !ENDBR: crypto_xchacha_crypt+0x0
> 
> followed by warnings at the end
> 
> |   AR      vmlinux.a
> |   LD      vmlinux.o
> | vmlinux.o: warning: objtool: .sframe+0x15c: data relocation to !ENDBR: repair_env_string+0x0
> | vmlinux.o: warning: objtool: .sframe+0x1c0: data relocation to !ENDBR: run_init_process+0x0
> | vmlinux.o: warning: objtool: .sframe+0x1d4: data relocation to !ENDBR: try_to_run_init_process+0x0
> | vmlinux.o: warning: objtool: .sframe+0x1e8: data relocation to !ENDBR: rcu_read_unlock+0x0
> …
> | vmlinux.o: warning: objtool: .sframe+0x12765c: data relocation to !ENDBR: get_eff_addr_reg+0x0
> | vmlinux.o: warning: objtool: .sframe+0x1276ac: data relocation to !ENDBR: get_seg_base_limit+0x0
> |   OBJCOPY modules.builtin.modinfo
> 
> followed by a boom
> |   LD      .tmp_vmlinux1
> | ld: error: unplaced orphan section `.sframe' from `vmlinux.o'
> 
> We could drop the sframe during the final link but this does not get rid
> of the objtool warnings so we would have to ignore them. But we don't
> need it. So what about the following:
> 
> diff --git a/Makefile b/Makefile
> --- a/Makefile
> +++ b/Makefile
> @@ -886,6 +886,8 @@ ifdef CONFIG_CC_IS_GCC
>   KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)
>   KBUILD_CFLAGS	+= $(call cc-option,-fno-allow-store-data-races)
>   endif
> +# No sframe generation for kernel if enabled by default
> +KBUILD_CFLAGS	+= $(call cc-option,-Xassembler --gsframe=no)
>   
>   ifdef CONFIG_READABLE_ASM
>   # Disable optimizations that make assembler listings hard to read.
This is what I chose for package builds that need disablement of sframe.

