Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2E776661D
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jul 2023 10:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbjG1IAh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jul 2023 04:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjG1IAM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jul 2023 04:00:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3342330EA;
        Fri, 28 Jul 2023 00:59:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690531127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J2d/NQgST3OleKl0Jw+5SHcTojuKsykf8D+CZyk9mUA=;
        b=h3KqjBdPA4v2gP3IJl3i4HKURHxrs7Z5zalvYFOXjqo5taHgckMES/Ak2aXstzmdk0h1Zl
        vdGk9Q44NlT4AJ29PCV0W6W2q8tx8RidGxHWChicPXnOZ6vUUtCWGERVTYO4tDd2C1KHE9
        6HQ18KUtgSpdSIRwHAHpW9flJMyN5Qr5e0T+LkogiYQs907k+p6PVC2lLIVNMa8QCnI5Tj
        Uh5F7gzHbWSHqEOXp2w4AKIl7Wu8PiRg9uoRzKFIEaDL0AVSPbGeKlL7hQb5f0dAGbHeTM
        MkHPtBbVI7dAu6zjZ9YVGAgxNixDe8ZxyysVnQzvhPUUk5c04LeQ8A6yPwZprg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690531127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J2d/NQgST3OleKl0Jw+5SHcTojuKsykf8D+CZyk9mUA=;
        b=v0mAYXzamMC3q0Q2OV8KW7XiJxlxCHl7htvJxDhy7rV+jL9o+Kr7oEtmoThFL05diOag8V
        MnN8MMUFkbWycpAw==
To:     Laurent Dufour <ldufour@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        rui.zhang@intel.com
Subject: Re: [PATCH v4 00/10] Introduce SMT level and add PowerPC support
In-Reply-To: <20230705145143.40545-1-ldufour@linux.ibm.com>
References: <20230705145143.40545-1-ldufour@linux.ibm.com>
Date:   Fri, 28 Jul 2023 09:58:46 +0200
Message-ID: <87tttoqxft.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Laurent, Michael!

On Wed, Jul 05 2023 at 16:51, Laurent Dufour wrote:
> I'm taking over the series Michael sent previously [1] which is smartly
> reviewing the initial series I sent [2].  This series is addressing the
> comments sent by Thomas and me on the Michael's one.

Thanks for getting this into shape.

I've merged it into:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core

and tagged it at patch 7 for consumption into the powerpc tree, so the
powerpc specific changes can be applied there on top:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-for-ppc-23-07-28

Thanks,

        tglx
