Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228EF5BBD5D
	for <lists+linux-arch@lfdr.de>; Sun, 18 Sep 2022 12:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiIRKFu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Sep 2022 06:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIRKFt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Sep 2022 06:05:49 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63671C922
        for <linux-arch@vger.kernel.org>; Sun, 18 Sep 2022 03:05:48 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso27874pjk.0
        for <linux-arch@vger.kernel.org>; Sun, 18 Sep 2022 03:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date;
        bh=d/wxx4iWyVgQOkswP2hVsavkLpdK+7bXx+tSZhX51o0=;
        b=peuct5ZyDpnnGsosOiZzuaf8D7N7LI9gIpMPjlEX0FzOOn1+dmtES5ugGR9SKR3W3L
         /TggSWme2mTnAhoPHbeXtejFdeZPetfRCOuvhEY4mVOtJgv8ym0vQQhBcijQUpoGKdq+
         dz/dSZaRy6ZqfXA4vcPVPGmGGYr8PZ2YMEo6DuFYIdjX7mMKRUKIQB/D6qHeIy+LniCD
         jyLC0vZEpa5lEt8KGQw7jDIW0LEnKItXHz2aDqrGt94mdqs4tPk2Y4gWsPgRzr2elhAd
         PB80l1yNzo2MPYC3WUDxRG00sASezsW9ys8Cri9yeTZ+G4NudGAdi1/xsjybe4R3iaC5
         Yq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date;
        bh=d/wxx4iWyVgQOkswP2hVsavkLpdK+7bXx+tSZhX51o0=;
        b=ywOFMcwG1tlGGjmWt4Z1TzAN6OEFuvQ+tGie/wVEgp3pvwfK9vVeSmlerVazHwxsyw
         T/4TN1MXaSu7WmNMNFygVKmb7ks1maYr8nm4JGDel7EghTMYXb+27Q4+AtmRrZnmcZE2
         B5d+HA6/7FyRKOPP5G8EoxKcMLXQvYcPB/4QIqVe6YKZjmTFG8DCz2Z6Y77646UhzXhR
         +rctoBJtrX1nidUpz3rJ/MG6984DC7MBEqGEzvtqdxky6li9e2w6J672SlJDEv9ULyV8
         kmNX9w6LDroD9GUOSBHFC9bMinPj6M+gFMH9zdIqpu8loA2w6AnCjBavU4QzNR10+G9e
         BF8g==
X-Gm-Message-State: ACrzQf1jHvuQe0KjA2/12QU1mPJHqkUtH7KFC4gKyEHCXjzTCh597zIP
        29ZKYsZok7udmtjIAr/RkNbCsn5upjuBgTsuEwE=
X-Google-Smtp-Source: AMsMyM4h5IDMu3QiJCBrIJE4G+mnm4sAC9KP0Nq9Z8Mg3ntGP4YB4fk85xdOHPGP1W3cMesVpzRCLA==
X-Received: by 2002:a17:903:124e:b0:178:6946:a2ba with SMTP id u14-20020a170903124e00b001786946a2bamr7891419plh.89.1663495548260;
        Sun, 18 Sep 2022 03:05:48 -0700 (PDT)
Received: from localhost (vpn-konference.ms.mff.cuni.cz. [195.113.20.101])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902cec200b0015e8d4eb219sm18366335plg.99.2022.09.18.03.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 03:05:47 -0700 (PDT)
Date:   Sun, 18 Sep 2022 03:05:47 -0700 (PDT)
X-Google-Original-Date: Sun, 18 Sep 2022 03:05:41 PDT (-0700)
Subject:     Re: [PATCH v4] riscv: Fix permissions for all mm's during mm init
In-Reply-To: <CAHk-=wg0vQFgiBEuJKHzxrS8JB=CxJFNf5WgtaofRn+bqs65oA@mail.gmail.com>
CC:     vladimir.isaev@syntacore.com, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, ajones@ventanamicro.com,
        conor.dooley@microchip.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-16e91ca9-0ee8-4103-845e-56e9b394cae0@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 17 Sep 2022 11:58:48 PDT (-0700), Linus Torvalds wrote:
> Sorry for html crud, I'm afk right now.
>
> But no, this does not help at all.
>
> Now you're doing a blocking semaphore operation under a spinning rwlock
> instead.
>
> Which also is completely invalid.
>
> Your can't do blocking locks in atomic context, and it doesn't matter
> whether the atomic context is a rcu read section or a spin lock.

OK, sorry for screwing up a second time.  I'll go try and make sure we 
get this right before sending anything up.  Vladimir: I'll just take 
this one over and send a v5, I'll find some time this week to make sure 
I can get it right this time.

Sorry for the mess!

> Stop making random locking changes like this. And enable lockdep and the
> lock verification that would have told you all this immediately.
>
>        Linus
>
>
> On Sat, Sep 17, 2022, 11:48 Vladimir Isaev <vladimir.isaev@syntacore.com>
> wrote:
>
>> );
>> +
>> +       read_lock(&tasklist_lock);
>> +       for_each_process(t) {
>> +               if (t->flags & PF_KTHREAD)
>> +                       continue;
>> +               for_each_thread(t, s) {
>> +                       if (s->mm) {
>> +                               __set_memory_mm(s->mm, start, end,
>> set_mask,
>> +                                               clear_mask);
>> +                       }
>> +               }
>> +       }
>> +       read_unlock(&tasklist_lock);
>>
