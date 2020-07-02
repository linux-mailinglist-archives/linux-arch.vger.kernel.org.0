Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCF721216E
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 12:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgGBKge (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 06:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgGBKge (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 06:36:34 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418A8C08C5C1;
        Thu,  2 Jul 2020 03:36:34 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g67so12378672pgc.8;
        Thu, 02 Jul 2020 03:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=zjqH5OyJ0uNgtW+k6QC+tgZu9cOQCPtDoHSfO1sMDg4=;
        b=gKLSXxs5Xi0ffOI4xaSGtq2l4qx855x5dafTHDq9WcXO7TQYplArFpssod2qR5iroc
         Z//J/E+Jxf2dWCBbYKBHXFVD+w+CXtshhKTHJdbD/O3iC89Fj08aafiZCVEJF2cOTrNE
         4O5RqYQhri/vkSqkCRh9y8WiBO96ojL+4z4rqkLZXntWV5WAPiQZgcI1l0fnRFTFW50B
         rnTXdlfNOfTTwQ8ZKKGlQmHh4n8MfQVtn/MOtzbdTacVyDrkzZeO+Bdvyer8wuGkuL/S
         WC2gdd9tZnGshLR1E2a6JkZgt2oEw8jXurog9U4CI9OV0MLCeiLynDz8keltOuHYW5qY
         QHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=zjqH5OyJ0uNgtW+k6QC+tgZu9cOQCPtDoHSfO1sMDg4=;
        b=OMKzmtoor52GMkXfpxH9CF6tApxEDhYSi3Lq4nGbj3OD5DNd/KhstIQIKlsPP8COvh
         c2o3MhShBrPM00kzjI/rvOgHw5J4D0gacHHFX/SBs6hSniHTdijrzGmAVL0jEqGzxTUe
         Yq8FrBlJvKdj3nT+6OlC2ZHY8IDyQfKEfXiR/0tiGb4n0CBUfWBaNJK+FAA6VUkuWoAc
         esEXUpqB+9FIxlbNaBCuApUtY1sO/Um/Wq9xCzQy3XJMPDfIczXs0oUNnR9FWagssWxU
         2xXT/LMtQ817HFnjlJ58S3hGYdF0C8jRne8SCGc6uHSC2f0yjiKNjABamXeKok7uTsJN
         5M0A==
X-Gm-Message-State: AOAM533P3TI7eSgmJMzTUrcjgZNwgVz8SqCHYZiStpGRauvZ3kkKQewn
        PNVnjDd5u1ISX8zpagp5owo=
X-Google-Smtp-Source: ABdhPJzDNFrzM9gHS1aXVkfvYMpILRrQRmwBPh5wcimghMwI/lqsx8PhEr//gfgskebXTyEDOTJ33g==
X-Received: by 2002:a63:8f18:: with SMTP id n24mr23072639pgd.432.1593686193761;
        Thu, 02 Jul 2020 03:36:33 -0700 (PDT)
Received: from localhost (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id i128sm8838706pfe.74.2020.07.02.03.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 03:36:33 -0700 (PDT)
Date:   Thu, 02 Jul 2020 20:36:27 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/8] powerpc/pseries: use smp_rmb() in H_CONFER spin yield
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Anton Blanchard <anton@ozlabs.org>,
        Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>
References: <20200702074839.1057733-1-npiggin@gmail.com>
        <20200702074839.1057733-3-npiggin@gmail.com>
        <20200702082840.GC4781@hirez.programming.kicks-ass.net>
In-Reply-To: <20200702082840.GC4781@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1593685552.uh4kepm08t.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Peter Zijlstra's message of July 2, 2020 6:28 pm:
> On Thu, Jul 02, 2020 at 05:48:33PM +1000, Nicholas Piggin wrote:
>> There is no need for rmb(), this allows faster lwsync here.
>=20
> Since you determined this; I'm thinking you actually understand the
> ordering here. How about recording this understanding in a comment?
>=20
> Also, should the lock->slock load not use READ_ONCE() ?

Yeah, good point. Maybe I'll drop it from this series, doesn't really=20
belong I just saw the cleanup and didn't want to forget it.

We we just ordering the two loads in this function, and !SMP isn't a=20
concern (i.e., no issues of !SMP guest on SMP HV), but yeah fixing
the lack of comment is warranted, thanks.

Thanks,
Nick
