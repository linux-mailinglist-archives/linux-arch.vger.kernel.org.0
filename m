Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E553B4AEA7E
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 07:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbiBIGno (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 01:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiBIGnm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 01:43:42 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DDEC0401C7;
        Tue,  8 Feb 2022 22:43:46 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u6so2276156lfm.10;
        Tue, 08 Feb 2022 22:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pAAzM9YEmsN6BS7NBJa5z8OM37Zy1PTMVGmhl1fo81w=;
        b=FlVvYLWZE91QEPrPjnkeKbrPdSH+5IeJN/XcHoBhkj2vD8EH3wR/24NglxFpdb+eTM
         +Odo2S8UX7+C1f+j+JnNN86RN0MrROOerK5spsgTF6441CEsncZo/EiJgLd0UrXyq4ew
         qHQXBblQ10ly18eF9co0j+Qc2WNfBqX5upTijJ/pjxqLnI8t+ay/agCNONO08mJ5AA1F
         0ITPdrQi+oJsoFHrbIY0yP36MjyXKjJalN84O6oJ72h0/6YvgWje0y4XPRZiDWDr5CDT
         n5JCD0U1OKqfyDCf0nIdC1BI7qsCi7MOC0jApbRuMropCtd+nHE/kgkqk9z586rPkztl
         FYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pAAzM9YEmsN6BS7NBJa5z8OM37Zy1PTMVGmhl1fo81w=;
        b=4J2o/wuZ3ZQn0gX1G8vxcly/RJJ04IULveF2oUi6s904Rdv2l0RuKSEVer3DbcVXPB
         DKmOd/MpbEpR5T7uEo+T+HS6iHZ2F0xe0afrqF04UXpDPijGR6pSnzD9GGsk+46BJp1h
         bbooWN/flwAcmF7YdbIwvncQBsFX+xaIxUnuJqA8o4z47OKOPo0XacX9LLJCxFK2qMiR
         YjaNV/mr0jLuOCxDkOFr/Lcr/OxOEzD0jrsBuTWcmcnX3jBLR+Xo8L9qWuD+q/EU+UtF
         HdmHRJQMoXHFSDysW4WVlbJjGHRGfdLFYvE8YWrrz+DKavER1CHmI4N2woQqBO0JZA8c
         PAXg==
X-Gm-Message-State: AOAM532hYOySh1LlGWvsXEs/cEH2IYboDCuNimrzb5I5ktnU8/gMdXL3
        nIQPv1w6y3B1u0Y73GDYBoM=
X-Google-Smtp-Source: ABdhPJypQnDZgbJ8Curzq6PkvfxuGqIegGNX0qm0cm40T1ctE7nHCinC134HL2iJXR+3MIPZGN5BQw==
X-Received: by 2002:a05:6512:b11:: with SMTP id w17mr590074lfu.381.1644389024921;
        Tue, 08 Feb 2022 22:43:44 -0800 (PST)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id e13sm2328340ljj.85.2022.02.08.22.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 22:43:43 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 349FD5A0020; Wed,  9 Feb 2022 09:43:43 +0300 (MSK)
Date:   Wed, 9 Feb 2022 09:43:43 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Lutomirski, Andy" <luto@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "adrian@lisas.de" <adrian@lisas.de>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "avagin@gmail.com" <avagin@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        alexander.mikhalitsyn@virtuozzo.com
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Message-ID: <YgNin5wkSaixCwdx@grain>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <YgAWVSGQg8FPCeba@kernel.org>
 <YgDIIpCm3UITk896@lisas.de>
 <8f96c2a6-9c03-f97a-df52-73ffc1d87957@intel.com>
 <YgI1A0CtfmT7GMIp@kernel.org>
 <YgI37n+3JfLSNQCQ@grain>
 <357664de-b089-4617-99d1-de5098953c80@www.fastmail.com>
 <YgKiKEcsNt7mpMHN@grain>
 <8e36f20723ca175db49ed3cc73e42e8aa28d2615.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e36f20723ca175db49ed3cc73e42e8aa28d2615.camel@intel.com>
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

On Wed, Feb 09, 2022 at 02:18:42AM +0000, Edgecombe, Rick P wrote:
...
> 
> Still wrapping my head around the CRIU save and restore steps, but
> another general approach might be to give ptrace the ability to
> temporarily pause/resume/set CET enablement and SSP for a stopped
> thread. Then injected code doesn't need to jump through any hoops or
> possibly run into road blocks. I'm not sure how much this opens things
> up if the thread has to be stopped...
> 
> Cyrill, could it fit into the CRIU pause and resume flow? What action
> causes the final resuming of execution of the restored process for
> checkpointing and for restore? Wondering if we could somehow make CET
> re-enable exactly then.
> 
> And I guess this also needs a way to create shadow stack allocations at
> a specific address to match where they were in the dumped process. That
> is missing in this series.

Thanks Rick! This sounds like an option. I need a couple of days to refresh
my memory about criu internals. Let me CC a few current active criu developers
(CC list is already big enough though:), maybe this will speedup the procedure.
