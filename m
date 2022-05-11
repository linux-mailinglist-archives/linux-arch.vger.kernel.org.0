Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2C7523C1A
	for <lists+linux-arch@lfdr.de>; Wed, 11 May 2022 19:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345959AbiEKR7a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 May 2022 13:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345953AbiEKR73 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 May 2022 13:59:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C916FA2A
        for <linux-arch@vger.kernel.org>; Wed, 11 May 2022 10:59:27 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id n10so5618594ejk.5
        for <linux-arch@vger.kernel.org>; Wed, 11 May 2022 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vpvF/G4xuVb2lXY63PSPtbidovxryyw3Az5XWwC60vo=;
        b=RbK3zt9fAFVilHkcwWN9jceetynxrMvtlrXzPTlVar2ZD6mqSxmFHhHsJvVdGdj8oI
         BdUObZOYI75NcJ2SSDoRa5dgZGU0KHn4S4ony/g70hsqCPjT2fqxPmixaO08qir+9s1k
         sMGXhofMo+yhDn2YS7Eyv334cFNRehtrMjd18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vpvF/G4xuVb2lXY63PSPtbidovxryyw3Az5XWwC60vo=;
        b=Ofq/nTikO0/L3ZaIsMguLDNojfUQZkSCi1Zl/AEMgqiABLbEK9VM5rT0uzxcmT2YwO
         gmIGsg8B4jWFXHgH5KorZOqS6M2w3qeoMHiYFvLPx8btAPpGowpPSb8BEwOR2uMqHcBX
         P1YZSkK3TaqhbJI2ipUAC2c+0Kq52X5He3NK/m9yKwEg07NG+/dFwYRiFBII74GB3zU0
         mY7cDknzZZMXOgXSobj2E0qnnFF6x+0znZTEUdQa29b3gb9gQ/jUq9sJzbeOcq+KaeoV
         gBmkVtbejwDbVLaT2JZLlv78ioy6L89+glh1cV0hEypfj9wmXu8alDqpUiRZji/mD2Qg
         IV6w==
X-Gm-Message-State: AOAM5307kPlhJT/yWuEvK6K6NyqtLmzrzuwav99o7J2HOob07rAy1WVf
        DYgJzsNWPI9cJB9DalWbImDZb+auv12Lp59kVP8=
X-Google-Smtp-Source: ABdhPJy5EEvY9RQiW6YJfttHzfQyraIOX11unUn+feEzoRoGnAGhJVtXt/BJR+SJ8HtwFN1OVNGyzA==
X-Received: by 2002:a17:907:2da9:b0:6f8:6104:659 with SMTP id gt41-20020a1709072da900b006f861040659mr20500994ejc.556.1652291965935;
        Wed, 11 May 2022 10:59:25 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id h13-20020a50ed8d000000b0042617ba63d2sm1409889edr.92.2022.05.11.10.59.24
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 10:59:24 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id r188-20020a1c44c5000000b003946c466c17so1072611wma.4
        for <linux-arch@vger.kernel.org>; Wed, 11 May 2022 10:59:24 -0700 (PDT)
X-Received: by 2002:a7b:c8d6:0:b0:394:25ff:2de with SMTP id
 f22-20020a7bc8d6000000b0039425ff02demr5994279wml.154.1652291964221; Wed, 11
 May 2022 10:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <CANpfEhOnNZa5d_G3e0dzzbbEtSuqxWY-fUCqzSiFpiQ2k0hJyw@mail.gmail.com>
 <CAHk-=wjfecvcUk2vNQM1GiUz_G=WQEJ8i8JS7yjnxjq_f-OgKw@mail.gmail.com>
 <87a6czifo7.fsf@email.froward.int.ebiederm.org> <CAHk-=wj=EHvH-DEUHbkoB3vDZJ1xRzrk44JibtNOepNkachxPw@mail.gmail.com>
 <87ilrn1drx.ffs@tglx> <877d7zk1cf.ffs@tglx> <CAHk-=wiJPeANKYU4imYaeEuV6sNP+EDR=rWURSKv=y4Mhcn1hA@mail.gmail.com>
 <87y20fid4d.ffs@tglx> <87bkx5q3pk.fsf_-_@email.froward.int.ebiederm.org>
 <87mtfu4up3.fsf@email.froward.int.ebiederm.org> <87r150ug1l.fsf_-_@email.froward.int.ebiederm.org>
 <CAHk-=whUy_cuJsVeob4zDnK5sWpE3U2EjVbnR2xobqgx7DOp4g@mail.gmail.com> <87zgjot0qr.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87zgjot0qr.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Wed, 11 May 2022 10:59:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgT7XdnjJhJmsc342ouHiDu2oxcguziHSL21UH3jsnrCw@mail.gmail.com>
Message-ID: <CAHk-=wgT7XdnjJhJmsc342ouHiDu2oxcguziHSL21UH3jsnrCw@mail.gmail.com>
Subject: Re: [PATCH 8/7] sched: Update task_tick_numa to ignore tasks without
 an mm
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 11, 2022 at 10:53 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> I do have it in a public git branch.  The testing in linux-next
> is what revealed this.
>
> However it is a topic branch that as far as I know no one depends
> on so I should be able to rebase it.

Not a big deal, since it needs to not just bisect into that small
series, you also need a certain amount of bad luck to then hit the
issue.

So I don't think you should rebase unless you have other reasons to do
so, but if you do, just put this commit either first, or fold it into
the commit that removes PF_KTHREAD for threads that will become user
threads.

                  Linus
