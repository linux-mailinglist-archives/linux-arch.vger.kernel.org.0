Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF73341F238
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 18:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355046AbhJAQhy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 12:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355081AbhJAQhx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 12:37:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E3AC061775
        for <linux-arch@vger.kernel.org>; Fri,  1 Oct 2021 09:36:08 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u18so41240956lfd.12
        for <linux-arch@vger.kernel.org>; Fri, 01 Oct 2021 09:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jD7nwgHxMSeInUUrs6FJvRIyAdhMaTevfxCsu5BdLTM=;
        b=PpsqrsGdIFtn0KUPuJCzf5kI4Ojb7JegjF0BMY8LGcnxojJcyAKH5k+wMEqCTVCgzl
         1JQOIKyWlYlFXvLkV+P4j2KXRW+vn73pOipkMa/rdLBsfXs2C5ON06epk0gG2f0lb3JE
         TuSCdW5hFzBNhpbQQUh5N3vycq4ZQXUL7ShOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jD7nwgHxMSeInUUrs6FJvRIyAdhMaTevfxCsu5BdLTM=;
        b=Jj4pjimEKAmoIEycmBZAiz2DLs7oiG5+GhGVV6Uvm8UOQg7KUKPySFZrNo1royZ5SW
         MoYZuBWyZQalQIMDAd9AbISq5BJuUwUUQu0oSCgvIx6L+iOYmS6qL+lhEqjMNFtIxFmR
         D+jhC4YU3m+Gy3ghylsvk+elcXTljOgjYnIa+lA2mFaItZa2OYYZq4aB3HdvTvYbG+OO
         U1pFarskGtnTKj+jwRswQJgV9bAhNV6Qdmq5QJO35ZuN0KoSf3npWODs83p+fqGKG2hX
         XgOFnU8mIWq0FLeP2rtLPVxUUz4HWRBaXATnUMXDRO48STCGJMHv7neQfLzSvQfYRMqr
         k1dA==
X-Gm-Message-State: AOAM531KjEL0SRarQYQQntrzBkRSn4XF5XMPtaFThL0WYeOOxqPhr9vy
        r6/crJEtvADvbv0mRL17vTAsI2BpbblitVGaeKo=
X-Google-Smtp-Source: ABdhPJyQ7GyTFWC6cEHxIRueFndoG1fdQwi3bv3+XTF+CJWCKj6B0fG6cjlcmx+zo7cpK6M4MW5mVA==
X-Received: by 2002:ac2:5451:: with SMTP id d17mr6264226lfn.367.1633106166352;
        Fri, 01 Oct 2021 09:36:06 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id m25sm708283lji.52.2021.10.01.09.36.04
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 09:36:04 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id e15so41004061lfr.10
        for <linux-arch@vger.kernel.org>; Fri, 01 Oct 2021 09:36:04 -0700 (PDT)
X-Received: by 2002:a19:ef01:: with SMTP id n1mr6592631lfh.150.1633106163819;
 Fri, 01 Oct 2021 09:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
 <87lf3f7eh6.fsf@oldenburg.str.redhat.com> <20210929174146.GF22689@gate.crashing.org>
 <2088260319.47978.1633104808220.JavaMail.zimbra@efficios.com> <871r54ww2k.fsf@oldenburg.str.redhat.com>
In-Reply-To: <871r54ww2k.fsf@oldenburg.str.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Oct 2021 09:35:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgexLqNnngLPts=wXrRcoP_XHO03iPJbsAg8HYuJbbAvw@mail.gmail.com>
Message-ID: <CAHk-=wgexLqNnngLPts=wXrRcoP_XHO03iPJbsAg8HYuJbbAvw@mail.gmail.com>
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        j alglave <j.alglave@ucl.ac.uk>,
        luc maranget <luc.maranget@inria.fr>,
        akiyks <akiyks@gmail.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 1, 2021 at 9:26 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> Will any conditional branch do, or is it necessary that it depends in
> some way on the data read?

The condition needs to be dependent on the read.

(Easy way to see it: if the read isn't related to the conditional or
write data/address, the read could just be delayed to after the
condition and the store had been done).

               Linus
