Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3461A7730F7
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 23:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjHGVMb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 17:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjHGVMb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 17:12:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56311730;
        Mon,  7 Aug 2023 14:12:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691442748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WlKN2EXsCK3yaDpR0X1Jo/lbYsLihQJUYsc0lNCHmLk=;
        b=naGq6+47IM2x/yNjfYNecwcIK2O+ooL9cO+nUshqipcaFd+GWC9481gEYrqfxaHta2DXUr
        PLjW5lJ6lnPfgSnap3nq1ZDESC5Vj+iWcEsrzq7IOpoKioYbK3Fcngug/PCD9dDNICO9ty
        Jxybv12e689Twfexntaxh7Zq0kNHMEFjZerLD/JfcRWM4DBaThlOa6SHmywjUKXJZ5STin
        ynsHnQt4RxTdojo4X4mA35PDQPfynLOWmkyMHeuEvZsTKNnJXLil7owatGB07KTbWfOajj
        Zrrxkkf/gnZImw3BHxtfmKWXtbtukO1JTDTKvVrKlAvUeeWARqekWyUvw/O9Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691442748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WlKN2EXsCK3yaDpR0X1Jo/lbYsLihQJUYsc0lNCHmLk=;
        b=+XiigGsONJQQE5kTMQUgA/Ip/jaHIhHP6rDrilmTjLtEuqa75lQwKFJL5qoQYYRr2OBUgr
        1v8hLlZOZTkRTIAw==
To:     Peter Zijlstra <peterz@infradead.org>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH  v2 12/14] futex: Propagate flags into
 futex_get_value_locked()
In-Reply-To: <20230807123323.573374169@infradead.org>
References: <20230807121843.710612856@infradead.org>
 <20230807123323.573374169@infradead.org>
Date:   Mon, 07 Aug 2023 23:12:28 +0200
Message-ID: <87cyzytv43.ffs@tglx>
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
> In order to facilitate variable sized futexes propagate the flags into
> futex_get_value_locked().
>
> No functional change intended.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
