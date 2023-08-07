Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49370772E5C
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 20:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjHGS6w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 14:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjHGS6t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 14:58:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2643219A6;
        Mon,  7 Aug 2023 11:58:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691434721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YP2zK7ZMAVThEbj019VSrMDom4gG7G3CXJLRPYqN3Bk=;
        b=uWFiCYBhkxn+6kYZqMelMl+kg4iJMtuoKCoNEvZaf1yIxAHlT8U2c487idrMfRVhp/CpwZ
        ZZ/l95rq4Ho46MQeIQBzFPeH1WGr+wgwWzJTKDnNIcnFEFQPzfYZQADQQ3YM2h3t6pJJUn
        i4RY+0DEpaVHnX+wF2rnQd4G3xnhNSB+zA6Mg3AHa/mFCZEeAG0i/ChM5DcJcGd60FHoar
        0+w8FnjnoVbbhl4HaNtkMy4OpDegRF0AYRlAcShRDmbjvCJgMunc+/AOrJ2zdJvEI9AVyR
        A/MMn105X/NXBNHL8Qk1bVlGWmxRbCLyHZ6r88S/2r1R9x8nW/BBjnVefgnHmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691434721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YP2zK7ZMAVThEbj019VSrMDom4gG7G3CXJLRPYqN3Bk=;
        b=/wNw8ZUHVf4nUYcTeRYg5WDdSF3LFHqD5xIvOIi1XO2ciEjkKhkDaesaG73ZbEoZENZrlF
        otn9fgm2RZN23FBA==
To:     Peter Zijlstra <peterz@infradead.org>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH  v2 03/14] futex: Flag conversion
In-Reply-To: <20230807123322.952568452@infradead.org>
References: <20230807121843.710612856@infradead.org>
 <20230807123322.952568452@infradead.org>
Date:   Mon, 07 Aug 2023 20:58:40 +0200
Message-ID: <87r0oeu1b3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 07 2023 at 14:18, Peter Zijlstra wrote:
> Futex has 3 sets of flags:
>
>  - legacy futex op bits
>  - futex2 flags
>  - internal flags
>
> Add a few helpers to convert from the API flags into the internal
> flags.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
