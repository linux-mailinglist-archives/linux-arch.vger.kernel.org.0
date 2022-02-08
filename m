Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72C64ADED8
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 18:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383672AbiBHRCk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Feb 2022 12:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiBHRCh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Feb 2022 12:02:37 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774CBC061576;
        Tue,  8 Feb 2022 09:02:36 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 13so975306lfp.7;
        Tue, 08 Feb 2022 09:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H8i2s4xHp0rxY84LN1BxRLDP7j4EYhoJJT+IslnvpoI=;
        b=CeAOjWIQeZbI3marhQ90i70bJhrQHxUVRvRhMaA7tO26fi3eAnnwdrAiiS300jSV9/
         rFSHN4hYn1DFUV+ovphjx0xXDwujZlMu41W0cY9mh9STuL/ULgRD/Wpc6FL3E9W0MB9n
         jLShmsInPn/dCkb+n4MWvEH945FHvrOMejxdZhgHNF4js4UR2qDQTn/K6X8YvUU6bh2J
         CwADrvNHkjsZ90nrYWTIqhYSWrZTmKNZqq+w8ZDD1jbFN//e4zhAc83dzLx+Gq7+0Umg
         +DTbBao0meb6h15uFR49pmkJHnipUI1jYORJOXulRakWI6MK3fRCNb6YAeKE4+WTCV/V
         isYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H8i2s4xHp0rxY84LN1BxRLDP7j4EYhoJJT+IslnvpoI=;
        b=x24ylxJJPbDZ3UksW3/C9ZX5TLB5h/rB3Or+0367mT6F3eefU2y1wu7eOc7kdUWBY1
         i+1V6z9qI/HOO1rBlbSLUfaouRZkKe2J1FGM2DMAaxdbm4949mHm/R/oPsURALofY/XZ
         8rBcuHVrsk3xJlKUh11cQhxEE7S4/DvhLBK7s0bGGnpqoewmVLEXqnyur+FOYe9nLTY9
         wqUNp1Up76f0Xh2G2MgRyjLzoadI6mbxR4M+rl9KgZyxTR37HhWOaPrLjwqnrlIFNFHm
         7eDKXI+quol1YOAJrH/160x9nDs9E9YBHRFOetvAXfSU0KaUZOuXVIsRRSZyMEIBlW8q
         oEiA==
X-Gm-Message-State: AOAM530KjF306tVkKAZgHCfUTFL4YvxvypjGdpiLgM3dwbnAtObDvOK0
        SfZIVMWE88Ai93/Ziqpsny0=
X-Google-Smtp-Source: ABdhPJy4vAOsUuMcyywyagL71dLBFChw5CtMbZ5KClivwczQn/i8XjekNjbmQlZlpAVvbRy7btJhpg==
X-Received: by 2002:a05:6512:33c8:: with SMTP id d8mr3533852lfg.41.1644339754685;
        Tue, 08 Feb 2022 09:02:34 -0800 (PST)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id a12sm643118lfu.162.2022.02.08.09.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 09:02:33 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 80F685A0020; Tue,  8 Feb 2022 20:02:32 +0300 (MSK)
Date:   Tue, 8 Feb 2022 20:02:32 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Adrian Reber <adrian@lisas.de>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "kcc@google.com" <kcc@google.com>,
        "Eranian, Stephane" <eranian@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Message-ID: <YgKiKEcsNt7mpMHN@grain>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <YgAWVSGQg8FPCeba@kernel.org>
 <YgDIIpCm3UITk896@lisas.de>
 <8f96c2a6-9c03-f97a-df52-73ffc1d87957@intel.com>
 <YgI1A0CtfmT7GMIp@kernel.org>
 <YgI37n+3JfLSNQCQ@grain>
 <357664de-b089-4617-99d1-de5098953c80@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <357664de-b089-4617-99d1-de5098953c80@www.fastmail.com>
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

On Tue, Feb 08, 2022 at 08:21:20AM -0800, Andy Lutomirski wrote:
> >> But such a knob will immediately reduce the security value of the entire
> >> thing, and I don't have good ideas how to deal with it :(
> >
> > Probably a kind of latch in the task_struct which would trigger off once
> > returt to a different address happened, thus we would be able to jump inside
> > paratite code. Of course such trigger should be available under proper
> > capability only.
> 
> I'm not fully in touch with how parasite, etc works.  Are we talking about save or restore?

We use parasite code in question during checkpoint phase as far as I remember.
push addr/lret trick is used to run "injected" code (code injection itself is
done via ptrace) in compat mode at least. Dima, Andrei, I didn't look into this code
for years already, do we still need to support compat mode at all?

> If it's restore, what exactly does CRIU need to do?  Is it just that CRIU needs to return
> out from its resume code into the to-be-resumed program without tripping CET?  Would it
> be acceptable for CRIU to require that at least one shstk slot be free at save time?
> Or do we need a mechanism to atomically switch to a completely full shadow stack at resume?
> 
> Off the top of my head, a sigreturn (or sigreturn-like mechanism) that is intended for
> use for altshadowstack could safely verify a token on the altshdowstack, possibly
> compare to something in ucontext (or not -- this isn't clearly necessary) and switch
> back to the previous stack.  CRIU could use that too.  Obviously CRIU will need a way
> to populate the relevant stacks, but WRUSS can be used for that, and I think this
> is a fundamental requirement for CRIU -- CRIU restore absolutely needs a way to write
> the saved shadow stack data into the shadow stack.
> 
> So I think the only special capability that CRIU really needs is WRUSS, and
> we need to wire that up anyway.

Thanks for these notes, Andy! I can't provide any sane answer here since didn't
read tech spec for this feature yet :-)
