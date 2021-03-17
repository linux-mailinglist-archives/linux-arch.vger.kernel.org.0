Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F137833ECD7
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 10:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhCQJSP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 05:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhCQJSF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 05:18:05 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266D1C06174A;
        Wed, 17 Mar 2021 02:18:05 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k8so1020826wrc.3;
        Wed, 17 Mar 2021 02:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l4z7lY4hI142dOovIhBz7+RfJdWkutpjiBFHkQ9/Ugc=;
        b=LJiZLEDrsQlbLch095SF3X/dmTK2IpbpbVpHGUAxjURXChtyjN45ul9VUWWsa0FThd
         6AwExgL6x+x1DibDIBQZBViwrBX5cHKWpsYgd6m9dNyJ6TLmLwczOTC0UqGRWOVneGlV
         5fFP8QLyuTaF7RbWhoaUkMiKHKFRD8tuV3l5WPMGvt/elFHB+CJwmhWcTa0mAZ4IoTNT
         8riWznFLtlSeR/+BXE4GtGd0UAgozBiBTUIvKlIc3tG6KfpAyp4ZGWm5rw3o86/+6k3R
         M8uXJNQRraEpfmRzB8ZtugL6Kb51roPZjfSodcjUVYqEde86d+Hql5/zMNpmOe7VhiJ8
         h+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=l4z7lY4hI142dOovIhBz7+RfJdWkutpjiBFHkQ9/Ugc=;
        b=kq64nn6bqWYOtLHHLcGuLwzU8/2KYxgqIEqZD9WmfyMmZbYIkeeYAQXN/nN7HWYWMp
         5IVxTkeYpdfdOD6t/3NYLx8dru3FFp81NtHnGKInXiYFggcX1kWj/oNqsts8vnNIBfbP
         NCzgDgUrTWyb69guIk5450BLTYuUEIe8oioFJ3/2BBbkC6GkiAgy90z7unse5PRv/W3C
         G0WyhcIFPyMnL8g8aFVDRN/VzeH3MUfHhM4Bk7u/Xsii5TRnG83iwloDdIBBwdLxoUfS
         tKRP262+SMptHbd1xLGVpybycJI2iBRuJTXghM4+Nk3K+FLtLppbuIcUGqusT0IixPkB
         AkKg==
X-Gm-Message-State: AOAM531+dvf3/Kuo9d/XhvXcVaJ4yqteIEgVkjb+Ph4stPGSKd9o5Mu7
        rwOvkfX61g1IsjuHDTGB0xo=
X-Google-Smtp-Source: ABdhPJxuFNcXDJVAk2cwkK0X/n9SZAKsJQJ6VpBnv6zbLYXlB/zNrwu2rYXa+mhFZM3cGs78y3vWwg==
X-Received: by 2002:adf:ee4f:: with SMTP id w15mr3297179wro.199.1615972683925;
        Wed, 17 Mar 2021 02:18:03 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id h10sm24764669wrp.22.2021.03.17.02.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:18:03 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Mar 2021 10:18:00 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v23 00/28] Control-flow Enforcement: Shadow Stack
Message-ID: <20210317091800.GA1461644@gmail.com>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316211552.GU4746@worktop.programming.kicks-ass.net>
 <90e453ee-377b-0342-55f9-9412940262f2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90e453ee-377b-0342-55f9-9412940262f2@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:

> On 3/16/2021 2:15 PM, Peter Zijlstra wrote:
> > On Tue, Mar 16, 2021 at 08:10:26AM -0700, Yu-cheng Yu wrote:
> > > Control-flow Enforcement (CET) is a new Intel processor feature that blocks
> > > return/jump-oriented programming attacks.  Details are in "Intel 64 and
> > > IA-32 Architectures Software Developer's Manual" [1].
> > > 
> > > CET can protect applications and the kernel.  This series enables only
> > > application-level protection, and has three parts:
> > > 
> > >    - Shadow stack [2],
> > >    - Indirect branch tracking [3], and
> > >    - Selftests [4].
> > 
> > CET is marketing; afaict SS and IBT are 100% independent and there's no
> > reason what so ever to have them share any code, let alone a Kconfig
> > knob.
> 
> We used to have shadow stack and ibt under separate Kconfig options, but in
> a few places they actually share same code path, such as the XSAVES
> supervisor states and ELF header for example.  Anyways I will be happy to
> make changes again if there is agreement.

I was look at:

  x86/fpu/xstate: Introduce CET MSR and XSAVES supervisor states

didn't see any IBT logic - it's essentially all shadow stack state.

Which is not surprising, forward call edge integrity protection (IBT) 
requires very little state, does it?

With IBT there's no nesting, no stack - the IBT state machine 
basically requires the next instruction to be and ENDBR instruction, 
and that's essentially it, right?

Thanks,

	Ingo
