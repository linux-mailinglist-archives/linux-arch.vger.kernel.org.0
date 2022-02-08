Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5507F4AD4E2
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 10:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352729AbiBHJ3Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Feb 2022 04:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbiBHJ3X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Feb 2022 04:29:23 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D52AC03FEC1;
        Tue,  8 Feb 2022 01:29:22 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id j14so23571624lja.3;
        Tue, 08 Feb 2022 01:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9jFgBcCwyw+JzDYCLTCZj7IYtY0O/7Fz6FpDwFz3WSA=;
        b=Cxuiov0oEhEhABwISaLLYTLHN3tzQ6PF+RTizCxpWY8feQ6Sz2x+TM3jmZxxWmNjv0
         q28EFyaFYTlAbN1maWEM6RERHZTjoR/WE4mgvNqHUPt7F6oC+sNYeL39cBMJkac7Rt4k
         kUBoOyjvcvD5l4yg9lsDUOOVNrISyrJwp9TnBNmBymRYU5g+xMtxKKXGdSLwIbGt40Xr
         9xIN01VqwKLFRMjcCZqZdmBpwPLLHoO8truWxbF68Q80kAncmQE0NdLHt8zNjFWP7x3c
         bFBayng/aXL7nLzKIHE6ncR/BwiQDML3zbzzfgLrBoV66II6hhCr/WvsDuz+OaCQo3Nv
         Uy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9jFgBcCwyw+JzDYCLTCZj7IYtY0O/7Fz6FpDwFz3WSA=;
        b=L79+gecAXd+TkUFcY1fbPB9uM7A0iR5Oo0eh13n0QIo4HoEhYzAO/t+DQBv4HGYQIP
         LZeSF8q/t70KJ30pByt0cqk/OulCBwbWVxbw/Hy2YjrLQZ82Pz91AFD+N2XmH1zaFYmp
         42u6DiQfWgzTe6+pPymFeWTYFJEyuFOtri3FxinlEmXojzYCkcC4tgVD/t+EEo4/n8ER
         yZEibR6dfJGVEdPSq5JYr113YG9FH86IZopaEe/7WlWRzueTT5gesf/EUGbJ4CS+J+6P
         +4S35uWOt4KwgyIs3rIJ/q5QkAlCpDgnQGcPNFrSmJHEhmKB1p8tnqHB8UtsJLDMjfus
         ddUQ==
X-Gm-Message-State: AOAM532MZkSEdK7rmsE8WqPdmVej+E/mxiTcPVaTH+9tkz75HKuQIFz+
        jOdNmQG8wl5JE8907/OemHw=
X-Google-Smtp-Source: ABdhPJxU2OmzIM9fb0K8HePdfkwJ4Iqh+Y8JVXS0ExB8DZQYOb2juUMhr/5kpFM8JthwVNZVVhO1Yg==
X-Received: by 2002:a2e:8751:: with SMTP id q17mr2240779ljj.65.1644312560537;
        Tue, 08 Feb 2022 01:29:20 -0800 (PST)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id p16sm1958258ljc.86.2022.02.08.01.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 01:29:19 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id C01F55A0020; Tue,  8 Feb 2022 12:29:18 +0300 (MSK)
Date:   Tue, 8 Feb 2022 12:29:18 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Adrian Reber <adrian@lisas.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Message-ID: <YgI37n+3JfLSNQCQ@grain>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <YgAWVSGQg8FPCeba@kernel.org>
 <YgDIIpCm3UITk896@lisas.de>
 <8f96c2a6-9c03-f97a-df52-73ffc1d87957@intel.com>
 <YgI1A0CtfmT7GMIp@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgI1A0CtfmT7GMIp@kernel.org>
User-Agent: Mutt/2.0.7 (2021-05-04)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 08, 2022 at 11:16:51AM +0200, Mike Rapoport wrote:
>  
> > Any thoughts on how you would _like_ to see this resolved?
> 
> Ideally, CRIU will need a knob that will tell the kernel/CET machinery
> where the next RET will jump, along the lines of
> restore_signal_shadow_stack() AFAIU.
> 
> But such a knob will immediately reduce the security value of the entire
> thing, and I don't have good ideas how to deal with it :(

Probably a kind of latch in the task_struct which would trigger off once
returt to a different address happened, thus we would be able to jump inside
paratite code. Of course such trigger should be available under proper
capability only.
