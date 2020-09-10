Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29162264F8E
	for <lists+linux-arch@lfdr.de>; Thu, 10 Sep 2020 21:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgIJTqW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Sep 2020 15:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgIJTpr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Sep 2020 15:45:47 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F81BC061757
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2020 12:45:47 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g29so4857597pgl.2
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2020 12:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kT3st5L2W/yGrskNA7hV4WTKcp+VzTZ5Pgaqe30vqT8=;
        b=eC6xHFZebGzDOu2iJFlC4sYhGBsPBPtk9a7oklICzLNlEMzSAdGnasLCc1rhvVduzw
         WWGkAB927UqclP1++HPY0zndFIqCAsSEoCB33GsJW1zgx9zdnqi9fNwkG+wGtFEr+T3z
         bUYjH1Oc2jBMRnj0f0FQ3tH0tHQIOzzYF+914=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kT3st5L2W/yGrskNA7hV4WTKcp+VzTZ5Pgaqe30vqT8=;
        b=QAFl9r3DQiPkswxUTGkL7Trqk9L8h65h66zMWdwwnSfcFznT6EhgwrTuZ4Yb74uOJT
         +T7yRZbD/VNt5Mz/6TDyNEn1VY7eruImJEAcq/fSjlOV5o/WRRx64t/Zhc+lblLo5bv9
         uX71etnU6h5Zpo4DXrX2KZW3fq+TNOMSGzc2URTBz+WFAj/yodXB8Xp1+trUDeh25Psw
         yuAmwRSFLJKgxrMOIeuUBmvleJ9jcOo0ABkBXtUWpreMI4MF5wAQwAVmZBV2Sdc8sRMc
         2PnsqJ7jlH1cPKXKKzCY8DSLnIFcCkXoOjylJ7rH+Pmr/AxPzj4dnCdUZFVXWIEK+LHB
         qE3w==
X-Gm-Message-State: AOAM531KE28Wb2AGMBjhH6YKaOHWF8Mj/FzCKYVQ7jvEJ6MH10NiRi+n
        NLMOZj+VW/pdcI/lM3nfONg6xg==
X-Google-Smtp-Source: ABdhPJwWpKs77i2Pw4YhFhAT5cZe6s0qx17kIVE+as0BWVJNc55TKLnEBagdP5cQWEjWPugWxrbACw==
X-Received: by 2002:aa7:858e:: with SMTP id w14mr2753410pfn.95.1599767146631;
        Thu, 10 Sep 2020 12:45:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l79sm2905776pfd.210.2020.09.10.12.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 12:45:45 -0700 (PDT)
Date:   Thu, 10 Sep 2020 12:45:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-ia64@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Paul Mackerras <paulus@samba.org>,
        linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-arch@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>,
        Jessica Yu <jeyu@kernel.org>, linux-um@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, Tony Luck <tony.luck@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-arm-kernel@lists.infradead.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] kbuild: preprocess module linker script
Message-ID: <202009101245.493610D05@keescook>
References: <20200904133122.133071-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904133122.133071-1-masahiroy@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 04, 2020 at 10:31:21PM +0900, Masahiro Yamada wrote:
> There was a request to preprocess the module linker script like we do
> for the vmlinux one (https://lkml.org/lkml/2020/8/21/512).
> 
> The difference between vmlinux.lds and module.lds is that the latter
> is needed for external module builds, thus must be cleaned up by
> 'make mrproper' instead of 'make clean' (also, it must be created by
> 'make modules_prepare').
> 
> You cannot put it in arch/*/kernel/ because 'make clean' descends into
> it. I moved arch/*/kernel/module.lds to arch/*/include/asm/module.lds.h,
> which is included from scripts/module.lds.S.
> 
> scripts/module.lds is fine because 'make clean' keeps all the build
> artifacts under scripts/.
> 
> You can add arch-specific sections in <asm/module.lds.h>.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
