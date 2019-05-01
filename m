Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74AA210EBB
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2019 23:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfEAVsL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 May 2019 17:48:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39750 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfEAVsL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 May 2019 17:48:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id a9so349915wrp.6;
        Wed, 01 May 2019 14:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ISxFsNQTTZgb94Y+nE3oZI+k8F70LS/7cW4W/9uLa7U=;
        b=OcHYTYyMKiyld7evqlH2vdeCYcF6+pxC+w2hlQ6NSntJcjs0NMlozgV+dTlEL/aDOq
         1avpIR9qmwl7frnX6lGtFw28I/4yE0YIOzJ2L2zKHB4j4UKA8bOT12WDD7veT4UF1ghp
         +FDT3woAmbc/CncNlT/fZrWHrjkAheIS48VwSyK1mKF0Jla4P72Sqc4A7V2PHfSvZviI
         GkV5J/y2jdeWoIqUqAYJuhUj2+c5LDYpWz/uhfgeEBjhbmYn1q9ukrlNyJ7PuB8Kbw9P
         kfNcfc4h5RVllMCyxoPCh+LNvl5FoW1nTCXRkMZ7m677AVsP1LY36az1L1ULuODoYZv/
         jCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ISxFsNQTTZgb94Y+nE3oZI+k8F70LS/7cW4W/9uLa7U=;
        b=Av8yilIFc0fjuOSWlO+qE78vzVFAK3k4EQf2InrUwdbNY/LLIPecKm2fBvQpfbBWNZ
         vp/hHLxCvhEmkxqwKZf/iSLRNOg3l5vYieCGLJesh+odaIEq4Md1tn90lvzHlfvya1zm
         Y2B4gFSkSIgoKklA/jHk38bfj52fn1C4BUSMzEe783f8IPzvByYJX/IbKN5DEdMiUmVR
         shcZahihs2vIV6uymJiWeDZfqgk9mHtuwq/HIeouX6x6lX/YIjPQEpScQQbJuof+/7Uk
         VHEYZPWkMYzBJjKFOzlIgSJLjxPBqGzQfCpXgBbXqLJRluiJvmHiwg7ROUjQ2wpw+ccc
         Gq/A==
X-Gm-Message-State: APjAAAVXNVZ5X/byn36hxiaso+c+KcTvrZnGH8jOXhe7ay7yJGDShUkm
        KvO5WALsXK2yqr65gpz7KRE=
X-Google-Smtp-Source: APXvYqzWng3pdPQ2BP2fhMvQnPtjtHCcqRh/94dsv2GLRx9Y0hUc1T0Qby9lY2ggvwI9sBUOqXKlVA==
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr195674wrm.225.1556747289408;
        Wed, 01 May 2019 14:48:09 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d16sm34471858wrs.68.2019.05.01.14.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 14:48:08 -0700 (PDT)
Date:   Wed, 1 May 2019 23:48:05 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] x86: don't use asm-generic/ptrace.h
Message-ID: <20190501214805.GA54736@gmail.com>
References: <20190501173943.5688-1-hch@lst.de>
 <20190501173943.5688-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501173943.5688-5-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Christoph Hellwig <hch@lst.de> wrote:

> Doing the indirection through macros for the regs accessors just
> makes them harder to read, so implement the helpers directly.
> 
> Note that only the helpers actually used are implemented now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/include/asm/ptrace.h | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
> index 8a7fc0cca2d1..9b81ef539eb3 100644
> --- a/arch/x86/include/asm/ptrace.h
> +++ b/arch/x86/include/asm/ptrace.h
> @@ -98,7 +98,6 @@ struct cpuinfo_x86;
>  struct task_struct;
>  
>  extern unsigned long profile_pc(struct pt_regs *regs);
> -#define profile_pc profile_pc
>  
>  extern unsigned long
>  convert_ip_to_linear(struct task_struct *child, struct pt_regs *regs);
> @@ -175,11 +174,31 @@ static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
>  }
>  #endif
>  
> -#define GET_IP(regs) ((regs)->ip)
> -#define GET_FP(regs) ((regs)->bp)
> -#define GET_USP(regs) ((regs)->sp)
> +static inline unsigned long instruction_pointer(struct pt_regs *regs)
> +{
> +	return regs->ip;
> +}
> +static inline void instruction_pointer_set(struct pt_regs *regs,

Nit: missing newline between inline functions.

> +		unsigned long val)
> +{
> +	regs->ip = val;
> +}
> +
> +static inline unsigned long frame_pointer(struct pt_regs *regs)
> +{
> +	return regs->bp;
> +}
>  
> -#include <asm-generic/ptrace.h>
> +static inline unsigned long user_stack_pointer(struct pt_regs *regs)
> +{
> +	return regs->sp;
> +}
> +
> +static inline void user_stack_pointer_set(struct pt_regs *regs,
> +		unsigned long val)
> +{
> +	regs->sp = val;
> +}

Other than that:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
