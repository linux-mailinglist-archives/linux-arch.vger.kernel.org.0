Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6333B209719
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jun 2020 01:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388718AbgFXXVq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 19:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388711AbgFXXVp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 19:21:45 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C75C061573
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 16:21:44 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ev7so1436399pjb.2
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 16:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XsZH2ZlxCr6iT3L+49rRTJJnEJ39rkW4+RYUadIzOtA=;
        b=R9IB6Osrb2qY+Afwa3MRErRuIdvIh83bCWGDGkn1jNRVAI7V/i8wm4cDEgG3oqoLAv
         ELOwYrGok06AlaYBhZeZ+3IfjuhQsuGjYu2XatVJ/71OLiUAIZZySCSiajaFHNciHcFf
         e0IKPhqtq2BJSLy0T3JT47Wx5ej+SaC5oLqz/thfZAX/s5DAQJIfcE/zGNUmp4i50yLi
         wUXNjKP97yKO1chFosjCP6jHbHl9M5gNbhQQQZuBjkNuOh9sE2u/RnliQkupdRrTnB78
         ensm1H7mTXgoQvxbhovdB3WMbvG5GPp88KUT1PvrdRHxTRQ8uR2fd7wNsVlZSXgqslAt
         PztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XsZH2ZlxCr6iT3L+49rRTJJnEJ39rkW4+RYUadIzOtA=;
        b=pXR3Snf9Q9dLRb6t+R1ILLs9XuEknEyrSQRbnlklUI1H427P3Q+k66woZe8pqJvqCO
         34kB/6AgAxGT8FRj7XRs9LspaWdOTxLJz8x1vyR2SC9y+hea35ftL8hY+9mx4B+0j1H7
         vat3jK76m+OLCtiQc1UZoU8qYkGqqwCWPDFCifQb1gXGInVFsiOWQ6IEYKUujZ9r4xLx
         7CPHS/R+S/Rj4Apmb4bwJ+x835kvtTnSsw7DtoSKxX3KtDiAPq4cljHWH8nmClO/EUba
         hfAANuOXGEnThqTLQfc6cSFpfJHpUqf3YRhmaCYbsKgN3vvZLUu+89lUmX6eKeM1h4nr
         /L8w==
X-Gm-Message-State: AOAM532T/zUCHfDxFXi9X/z+eqNhShoWBQhQyJA8u3Khbmc4ki6yfYwH
        pywlB3JNZ2Zx/sCEw0xQRfJWcQ==
X-Google-Smtp-Source: ABdhPJyQvGPhhCDkDPs//GgXdG4S7pu68Q1Tt12Ksb/sgYYUwtokZaIU62eANn1ZR6ZjIyAunxBX0w==
X-Received: by 2002:a17:90a:ea18:: with SMTP id w24mr186844pjy.158.1593040903445;
        Wed, 24 Jun 2020 16:21:43 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id u61sm6452415pjb.7.2020.06.24.16.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 16:21:42 -0700 (PDT)
Date:   Wed, 24 Jun 2020 16:21:37 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 11/22] pci: lto: fix PREL32 relocations
Message-ID: <20200624232137.GA243469@google.com>
References: <20200624203200.78870-12-samitolvanen@google.com>
 <202006250618.DQj64eMK%lkp@intel.com>
 <CAKwvOdnREuOmN_Vinn8pn6fxEpjzCM1_=9tDzbd2z884GNLFeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnREuOmN_Vinn8pn6fxEpjzCM1_=9tDzbd2z884GNLFeA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 04:03:48PM -0700, Nick Desaulniers wrote:
> On Wed, Jun 24, 2020 at 3:50 PM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Sami,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on 26e122e97a3d0390ebec389347f64f3730fdf48f]
> >
> > url:    https://github.com/0day-ci/linux/commits/Sami-Tolvanen/add-support-for-Clang-LTO/20200625-043816
> > base:    26e122e97a3d0390ebec389347f64f3730fdf48f
> > config: i386-alldefconfig (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> > reproduce (this is a W=1 build):
> >         # save the attached .config to linux build tree
> >         make W=1 ARCH=i386
> 
> Note: W=1 ^
> 
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >    In file included from arch/x86/kernel/pci-dma.c:9:
> > >> include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_via_no_dac190' [-Wmissing-prototypes]
> >       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
> >          |                                             ^~~~~~~~~~~~
> >    include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
> >     1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
> >          |       ^~~~
> 
> Should `stub` be qualified as `static inline`? https://godbolt.org/z/cPBXxW
> Or should stub be declared in this header, but implemented in a .c
> file?  (I'm guessing the former, since the `hook` callback comes from
> the macro).

Does static inline guarantee that the compiler won't rename the symbol?
The purpose of this change is to have a stable symbol name, which we can
safely use in inline assembly.

Sami
