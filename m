Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A28C77310A
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 23:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjHGVP1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 17:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjHGVP1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 17:15:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35951B6;
        Mon,  7 Aug 2023 14:15:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691442924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MfahLn8s6IhKrFm2/ONalXKrUDG7t3dGqSRYFdbxHjo=;
        b=1u+B7186g20a/sFUuEcQVCD4kd6/uYDzvx8g4BxmBOBGMyvYUMjZo/BCQlwOSiIUvDEShf
        mhVcdNoI/SSYayloqQQFDB6nC22JotgtijV3v1zOuu389enmehsqcEEJx28Y8Ngd+DdwuD
        UOZu7fqRqDKiMNhRwlSGpkpDvbN8+52L+9GeJbUnrY58Hr0I81cBSXQlI6n1vYZRuar3gp
        7pZ5iesfFJ+ta6ikoqBD1i5E5ZPcfWIwr96YHpfOFntVJo72RY4VnraTKpoE+p++eaMLYA
        ZzZc19esEGhB7/RpNYh3kpNsnlpg2siMOuu+5c1INnQsHmPk+e13mKI39fysIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691442924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MfahLn8s6IhKrFm2/ONalXKrUDG7t3dGqSRYFdbxHjo=;
        b=0t9vhDGSCYwDARIGa3FbeyGGLc0GJyr9iTmvx0l4EL+tilgY3jeXJatAK7JRcAmc0cgWp+
        mqfm8Qxt2TXUmpAw==
To:     Peter Zijlstra <peterz@infradead.org>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH  v2 13/14] futex: Enable FUTEX2_{8,16}
In-Reply-To: <20230807123323.641470179@infradead.org>
References: <20230807121843.710612856@infradead.org>
 <20230807123323.641470179@infradead.org>
Date:   Mon, 07 Aug 2023 23:15:23 +0200
Message-ID: <87a5v2tuz8.ffs@tglx>
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
>  
>  	/*
> +	 * Encode the futex size in the offset. This makes cross-size
> +	 * wake-wait fail -- see futex_match().
> +	 *
> +	 * NOTE that cross-size wake-wait is fundamentally broken wrt
> +	 * FLAGS_NUMA but could possibly work for !NUMA.

Don't give people ideas :)

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
