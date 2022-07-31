Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910CB586176
	for <lists+linux-arch@lfdr.de>; Sun, 31 Jul 2022 22:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbiGaUwj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 31 Jul 2022 16:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiGaUwi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 31 Jul 2022 16:52:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F25120BA
        for <linux-arch@vger.kernel.org>; Sun, 31 Jul 2022 13:52:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a7so4077793ejp.2
        for <linux-arch@vger.kernel.org>; Sun, 31 Jul 2022 13:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8udE8uoB93uvyZlPSO/At6OnaISC9AjkEA/Lil/8ZIc=;
        b=RXdA/hhOuYtjtLsjICxxWIPOCtIg9FAGmddkvsILWsPwpb2CImUOlXGktmIH0KWcUU
         Oi+dPDgXdKM3kJUXZa130UlR6HcKO/DW117bkUjTs7cpTnrtBvPipCqXDXhEufsyyWPE
         KMS5LcZVx0m9S0gYoEn1AX8EQhQAb2kyFXfX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8udE8uoB93uvyZlPSO/At6OnaISC9AjkEA/Lil/8ZIc=;
        b=AifQ7dzP2d0LqU8xIFMUw5+jql7As9ZsB0t7QGkDYsw/vtbwoR3pwEqIRKP4iOVJ+N
         J9zyg+ON3olp4RNT/APxgv5c4w5EtmJl+tfDS1EQ5dQVSraF+E3gEfwfeb+JjhUgsX7s
         HAXyuxaAJlfzVl4j0A05cmCf6pVULtKwHwktOKaYXoS+5szaMX0uYL+GHXd3SudIXYgF
         cyx7CWO3lk4SHxXOlON2vvmyKXa/zJzPPfvHbd1ELabQtbxMkLrc3ppZ4jZJHdPl7PqR
         EKS5H7c8TifLRaJ64HgisCgFtAyAyXPRCNzpgWxj3vMVF1i/sRyzLkISTxTZSAtrOTrw
         a13Q==
X-Gm-Message-State: AJIora+oIOV6jXGvk/QLapLoSptcS66NdA6msZLyHtGV2MTH4Ydbj9i5
        COpR3scWyGzBPDWhWo4lyCopOM78MXyViuk+RTU=
X-Google-Smtp-Source: AGRyM1vSeVyMJLLTLepbxJhgNc2Jh6WTt2XdU5rC4FKRSOGEDPrNt/zIU36V01Ep+jD8UeMxVFoIvw==
X-Received: by 2002:a17:907:6090:b0:72f:3dc3:f0c8 with SMTP id ht16-20020a170907609000b0072f3dc3f0c8mr9581795ejc.539.1659300754128;
        Sun, 31 Jul 2022 13:52:34 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id s10-20020aa7c54a000000b0043d1eff72b3sm4358004edr.74.2022.07.31.13.52.33
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 13:52:33 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id tk8so17039143ejc.7
        for <linux-arch@vger.kernel.org>; Sun, 31 Jul 2022 13:52:33 -0700 (PDT)
X-Received: by 2002:adf:fc02:0:b0:21f:c94:8bda with SMTP id
 i2-20020adffc02000000b0021f0c948bdamr8351235wrr.193.1659300392079; Sun, 31
 Jul 2022 13:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com> <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jul 2022 13:46:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjY8Lfem5JvyUYMFwZVvE40=9fzDba_44au0w-hgaozJQ@mail.gmail.com>
Message-ID: <CAHk-=wjY8Lfem5JvyUYMFwZVvE40=9fzDba_44au0w-hgaozJQ@mail.gmail.com>
Subject: Re: [PATCH v2] make buffer_locked provide an acquire semantics
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 31, 2022 at 1:39 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> Do you think that wait_event also needs a read memory barrier?

Not really, no.

__wait_event() uses prepare_to_wait(), and it uses set_current_state()
very much so that the process state setting is serialized with the
test afterwards.

And the only race wait_event should worry about is exactly the "go to
sleep" vs "make the event true and then wake up" race, so that it
doesn't wait forever.

There is no guarantee of memory ordering wrt anything else, and I
don't think there is any need for such a guarantee.

If somebody wants that guarantee, they should probably make the
condition for wait_event() to be a "load_acquire()" or similar. Those
cases do exist.

                       Linus
