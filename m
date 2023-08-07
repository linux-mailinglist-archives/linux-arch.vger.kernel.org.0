Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59622772E67
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 21:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjHGTBO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 15:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjHGTBN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 15:01:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D9710F6;
        Mon,  7 Aug 2023 12:01:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691434863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PiEO6NIg937sHypTir7yOojP64nd2ALRT50aoFEoOKE=;
        b=aRMOu91uWxeBHc0c5zj3O7oyeJF6oDdT1EyR5h7WrTTzf+CO+0+TsrPvMMXzzF/c/cAGgT
        VmDwoBk6Q4ikJaceHZNqt5dEz9Lz2SYkSRh3Cwg4RaUFJfpRWmkBowHcJ6Jbk5kQc/Thsa
        8x2+ECWWXS9YdJ6EbbLYl3gealZKnFKDb7sgJMktY4PFoBhmOdKSkNcoPQb6XUjV+eZB/I
        ywjWJGE5JwIU6sfVAGXzZPiEK/YSQFmcKF/K1IhKLVoIxtvOgNqJpc88czhsRl+W9tbNQ4
        u070GWDsR2iDI1Ba6LQMaD4enUiH422v35w/G+p8etMzxLxiIsTVBXEYMk5pDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691434863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PiEO6NIg937sHypTir7yOojP64nd2ALRT50aoFEoOKE=;
        b=A2M+a4twJBCcb93nTtEUneYkth3jS4pDLuUf5S3P3d34tZ3PuyJpRyolmPD5fFxqytuM26
        NqIIyIvXp0HK2MDQ==
To:     Peter Zijlstra <peterz@infradead.org>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH  v2 08/14] futex: Add flags2 argument to futex_requeue()
In-Reply-To: <20230807123323.297438324@infradead.org>
References: <20230807121843.710612856@infradead.org>
 <20230807123323.297438324@infradead.org>
Date:   Mon, 07 Aug 2023 21:01:02 +0200
Message-ID: <87leemu175.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 07 2023 at 14:18, Peter Zijlstra wrote:

> In order to support mixed size requeue, add a second flags argument to
> the internal futex_requeue() function.
>
> No functional change intended.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
