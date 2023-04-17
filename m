Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF546E424E
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 10:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjDQIOn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 04:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDQIOm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 04:14:42 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A934194;
        Mon, 17 Apr 2023 01:14:40 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-54fbb713301so166926447b3.11;
        Mon, 17 Apr 2023 01:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681719279; x=1684311279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A4Os3dr8ojnrC3FQMNzZ9SxkQapJmMPc47/v8RETnk8=;
        b=BH+CDfZx2N9ZcbtJns70WTRBMhkR5ArWhqyXCuyT3yiXdVfMufgwvFCew0Efv6UKaB
         Tia5Lnq3l9vw2QQ0E3RoFhvxzAlqEWErRuqOUPQ2xyLL7UzA50F3TvmjjQk6P/rCkPcI
         ExfD1eyzU9obs17nRfczccbzrk4t9dqSWkmx9Uuw968xQxIXxT7AYqwQxg6LR6Q3wkGS
         d31jHc6KK0WPCFLisYjFegiRtqdUh7m+MEsoNApJxwLSW5c8mT6Pp/jCgwe6ooECUJpJ
         EPMdRcxHx2HP7qZzWcSEjQTl1fyZvQVJgRjuKaezsLzIS0ajZ50ejjcgPaikWq/Ss0Ud
         b8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681719279; x=1684311279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4Os3dr8ojnrC3FQMNzZ9SxkQapJmMPc47/v8RETnk8=;
        b=Y6o94QZ0i33F3rDaVMCTG8qLgw+LUtz5sayBkLP7ZrHHq4HAYXk6rvzSiXNTlI6Ga6
         LZBx2rVX516CKZtddXuFYpkFtXBONKM6nQBOwM/KTprGUq3wT7/FuL966I0uqGQoSjz2
         jB4CW10b0VAI48yZVy6WgUeHY6qBb2/iUc1mjNHVqqMKd3rJJtA0wotxAHOQreFY5RaM
         q579dEVZKKxHn0tGXuLiMDOYtPfKLSizcaI3tUaXvP2qWMYAFmzDEG3SaH8BKsVkXTwH
         ujOR0Io+dRTSZl1UwoBo3Z9hkdwGVY851/j+LXiJOVOk3G+m6RuaAM1cVBw5o4i5N1w1
         xIWg==
X-Gm-Message-State: AAQBX9fPwRVM3IR6SJSQpl7GG7CHVLIR1kNZC3lDhDr8GcN34bx6mogr
        o8fD2ZbWmyhuEdH/7EmoHMirJqidL1xj2OZeO+4=
X-Google-Smtp-Source: AKy350YD1tm08Nz2B7USYkth+bw6H1Eo/Lt6AG00O3UuMVmikLF/P03nRE0E2gnhxOAzJ46OT71GkLUJ/Iwx8P4WMyw=
X-Received: by 2002:a81:af0c:0:b0:54f:8566:495 with SMTP id
 n12-20020a81af0c000000b0054f85660495mr8898022ywh.1.1681719279655; Mon, 17 Apr
 2023 01:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230403174406.4180472-1-ltykernel@gmail.com> <20230403174406.4180472-14-ltykernel@gmail.com>
 <CAM9Jb+gsHLgkqFf=ydtv4_Tr1uE5qeMQu4PhnD-aJ10OvzBbhA@mail.gmail.com> <21210f9c-8831-9f5a-e391-0f44f277b024@gmail.com>
In-Reply-To: <21210f9c-8831-9f5a-e391-0f44f277b024@gmail.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 17 Apr 2023 10:14:28 +0200
Message-ID: <CAM9Jb+husLaxX7p+rR3xx=cLDUMXqJMk5RmzYRAvu3Tr6Y7EMg@mail.gmail.com>
Subject: Re: [RFC PATCH V4 13/17] x86/sev: Add Check of #HV event in path
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com,
        pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> >> +void check_hv_pending_irq_enable(void)
> >> +{
> >> +       struct pt_regs regs;
> >> +
> >> +       if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> >> +               return;
> >> +
> >> +       memset(&regs, 0, sizeof(struct pt_regs));
> >> +       asm volatile("movl %%cs, %%eax;" : "=a" (regs.cs));
> >> +       asm volatile("movl %%ss, %%eax;" : "=a" (regs.ss));
> >> +       regs.orig_ax = 0xffffffff;
> >> +       regs.flags = native_save_fl();
> >> +
> >> +       /*
> >> +        * Disable irq when handle pending #HV events after
> >> +        * re-enabling irq.
> >> +        */
> >> +       asm volatile("cli" : : : "memory");
> > Just curious, Does the hypervisor injects irqs via doorbell page when
> > interrupts are disabled with "cli" ? Trying to understand the need to
> > cli/sti covering on "do_exc_hv".
>
>
> Hi Pankaj:
>         Thanks for your review. Yes, Hypervisor still injects #HV exception
> when irq was disabled check_hv_pending() is called when
> there is a #HV exception. It checks irq flag and return back without
> handling irq event when irq was disabled.

o.k. Thanks for your reply! I am clear with this part.

But want to know if there is possibility when "do_exc_hv" would keep
handling irqs in the continuous while loop i.e from the update in the
hv doorbell page and that can result in DOS like scenario? Is there is already
a protection for this?

Thanks,
Pankaj
