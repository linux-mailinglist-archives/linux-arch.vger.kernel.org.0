Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C74523BC9
	for <lists+linux-arch@lfdr.de>; Wed, 11 May 2022 19:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345749AbiEKRms (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 May 2022 13:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345745AbiEKRmr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 May 2022 13:42:47 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FCC233A60
        for <linux-arch@vger.kernel.org>; Wed, 11 May 2022 10:42:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n10so5539377ejk.5
        for <linux-arch@vger.kernel.org>; Wed, 11 May 2022 10:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPRBvvBW0lETz5m8YN39fLl5gQS2Sga9Keu000AT3pU=;
        b=UgsIpw2ht5hPvVl099BLiCTT08ScStzT8c+FWysbU/Oy86z0w/uXgvQmDAbrMrlZGp
         32M+oWHwDOkmTg6SHbcv/oXEJ0MJdTVAVh/ePYx9g5bOD6ZGeqIGFzfzNDU5F1MuRwV2
         /mtUwL9J1sDC06DI+Q5uj5uScoyb2AKsRly0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPRBvvBW0lETz5m8YN39fLl5gQS2Sga9Keu000AT3pU=;
        b=mdSAnuS+fvzJzaEdHME844Pa0Ub652smCFsngRU2pcTGcy82SuZkzNb24vWpApqz7E
         quAF/8a7yKulg7nEx0jWHdj8/+1FcBHk8ifST5WKG2RxCL+4CwmRNIk5K1XeA3aS65+r
         yrsJZI0N+LbpPdQxtDkBChJTNf5m3T/fpoJMth+Qt7koGJ/cXMUllzDOU+ydI5hPp6WN
         VwMRqBZ2XSvt6OUjumRE5khscy7G3YwhcVjTnG9cqZp9GXU5TzjHN3SAW89Zpk0FjFat
         pdo0LMjMId7rK10tJwdhLXPV146ta07yZBfOMG29D0N6PHkpXglHMo8eBh4NzxIAz21Z
         3NMg==
X-Gm-Message-State: AOAM531dcGXFQy1nU1WD4iUF2XMOZJ3KG3uxB86ZPintpjN6C5GSigGY
        abi/gXQW7HETgeXEJMs+hrHLYYvCD03FTWLfegE=
X-Google-Smtp-Source: ABdhPJx3VfJ6v3RfO/MzWZmlgIG90BoHkXLpDsJ2jqIwPDbN1SAKRGGF/OoAZMUJzad4Ky6LShcXKA==
X-Received: by 2002:a17:907:9727:b0:6f8:823c:3653 with SMTP id jg39-20020a170907972700b006f8823c3653mr19155442ejc.741.1652290958850;
        Wed, 11 May 2022 10:42:38 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id n2-20020a170906700200b006f3ef214ddbsm1192026ejj.65.2022.05.11.10.42.37
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 10:42:38 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id v12so3976872wrv.10
        for <linux-arch@vger.kernel.org>; Wed, 11 May 2022 10:42:37 -0700 (PDT)
X-Received: by 2002:adf:dfc8:0:b0:20a:d256:5b5c with SMTP id
 q8-20020adfdfc8000000b0020ad2565b5cmr23591245wrn.97.1652290957387; Wed, 11
 May 2022 10:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <CANpfEhOnNZa5d_G3e0dzzbbEtSuqxWY-fUCqzSiFpiQ2k0hJyw@mail.gmail.com>
 <CAHk-=wjfecvcUk2vNQM1GiUz_G=WQEJ8i8JS7yjnxjq_f-OgKw@mail.gmail.com>
 <87a6czifo7.fsf@email.froward.int.ebiederm.org> <CAHk-=wj=EHvH-DEUHbkoB3vDZJ1xRzrk44JibtNOepNkachxPw@mail.gmail.com>
 <87ilrn1drx.ffs@tglx> <877d7zk1cf.ffs@tglx> <CAHk-=wiJPeANKYU4imYaeEuV6sNP+EDR=rWURSKv=y4Mhcn1hA@mail.gmail.com>
 <87y20fid4d.ffs@tglx> <87bkx5q3pk.fsf_-_@email.froward.int.ebiederm.org>
 <87mtfu4up3.fsf@email.froward.int.ebiederm.org> <87r150ug1l.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87r150ug1l.fsf_-_@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Wed, 11 May 2022 10:42:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whUy_cuJsVeob4zDnK5sWpE3U2EjVbnR2xobqgx7DOp4g@mail.gmail.com>
Message-ID: <CAHk-=whUy_cuJsVeob4zDnK5sWpE3U2EjVbnR2xobqgx7DOp4g@mail.gmail.com>
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

On Wed, May 11, 2022 at 10:37 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> With the change to init and the user mode helper processes to not have
> PF_KTHREAD set before they call kernel_execve the PF_KTHREAD test in
> task_tick_numa became insufficient to detect all tasks that have
> "->mm == NULL".  Correct that by testing for "->mm == NULL" directly.

If you end up rebasing at any time for other reasons (I didn't even
check if you keep this series in a public git branch), please just
fold this fix into the original commit, so that we don't have
unnecessary bisection issues.

               Linus
