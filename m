Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF28E753EB0
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jul 2023 17:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbjGNPWp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jul 2023 11:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbjGNPWo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jul 2023 11:22:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A9C269F;
        Fri, 14 Jul 2023 08:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bBqAMyX2AHoHemD+tuHzcjsCRInWCFSES1FRbicuNyA=; b=LfxgLtcS2gJ2h+UcRLdSWXsKqA
        i4ali0EFEsBwQnes/RyLBN3x2ouSfTyTsZf02qmM1q/hX/Wo6cDSWiSZLOK89K8uDXpDTVd4tomLX
        Mz0FoBPJRiEatUAfO2BoyZ2xXU27EWVO30lB6DZuL3T7Xy+eVToeUyjwcyy70MgeqLN+ycTZtV2HX
        YcVYiLXRfzwEotnj3Y9P4c7snBx+jkAsS7Poj5poZCHjUjeiVx1zqq3NjPVoJ8wUnTX2NxxdNsJ4P
        Fw81QGsT+P9nEUVRXMaCbx3OxZ0djVBtQb1I0j1JsTBYFZQ5UimcbyxTEq4g5DdSjLNENads3F+x8
        1K+U2JMg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKKci-006JMP-2n;
        Fri, 14 Jul 2023 15:22:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F04FE300274;
        Fri, 14 Jul 2023 17:22:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7B9D21372883; Fri, 14 Jul 2023 17:22:22 +0200 (CEST)
Date:   Fri, 14 Jul 2023 17:22:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [RFC][PATCH 07/10] futex: Implement FUTEX2_NUMA
Message-ID: <20230714152222.GD3261758@hirez.programming.kicks-ass.net>
References: <20230714133859.305719029@infradead.org>
 <20230714141219.081639007@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714141219.081639007@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 14, 2023 at 03:39:06PM +0200, Peter Zijlstra wrote:
> +	/*
> +	 * Encode the futex size in the offset. This makes cross-size
> +	 * wake-wait fail -- see futex_match().
> +	 *
> +	 * NOTE that cross-size wake-wait is fundamentally broken wrt
> +	 * FLAGS_NUMA but could possibly work for !NUMA.
> +	 */
> +	key->both.offset |= FUT_OFF_SIZE * (flags & FLAGS_SIZE_MASK);

this wee bit should've gone in patch 9.
