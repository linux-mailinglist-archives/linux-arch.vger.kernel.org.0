Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3026E772E47
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 20:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjHGS4z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 14:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjHGS4y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 14:56:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3D7172A;
        Mon,  7 Aug 2023 11:56:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691434611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L9kvFDfJK/VpB6H983DpvtzblFv1rzHcuGaRNzchB/w=;
        b=PLWdHUGTPIi0Q9xYqJtWserm2QJ2NQjjXIv2WYV/UIyxGuveFkZ7rOp6PkjyMovt0zUcPN
        SyZyx398pr5deNyametvyXlppxMRY/Vycxdpoz3YJZkazoMGCs+6ekf6qyEE+QKwsrvT4v
        9ZorphosC5ftnTCQEFecbtRqXWZdWf8Bvul6wNkh6yXJUr7oljJy/E4wW16t6dwNJ8HL3F
        XgFR8/WZ3Sxs5pfOJxVVDtq/o7e6PoB58vBBjkQ92OKODKHgOfI4y+niz4ZjX4RN6Sl72D
        QW5lQRG8y/45neF5y7DFNb2ghXPgsi/2q+LkH6szpAp2qEI8WeeXA4yaNaN8DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691434611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L9kvFDfJK/VpB6H983DpvtzblFv1rzHcuGaRNzchB/w=;
        b=7tiSmGGQa2wDUJU0+X2ovrxtd2Nyo/07cWAsSaot6S7MuZyjqbwXWW1u/mjWDtF3RGT7et
        HPLkFj1vuSmo4DCw==
To:     Peter Zijlstra <peterz@infradead.org>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH  v2 02/14] futex: Extend the FUTEX2 flags
In-Reply-To: <20230807123322.883413972@infradead.org>
References: <20230807121843.710612856@infradead.org>
 <20230807123322.883413972@infradead.org>
Date:   Mon, 07 Aug 2023 20:56:50 +0200
Message-ID: <87tttau1e5.ffs@tglx>
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
>  /*
>   * Flags for futex2 syscalls.
> + *
> + * NOTE: these are not pure flags, they can also be seen as:
> + *
> + *   union {
> + *     u32  flags;
> + *     struct {
> + *       u32 size    : 2,
> + *           numa    : 1,
> + *                   : 4,
> + *           private : 1;
> + *     };
> + *   };
>   */

Nice documentation

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
