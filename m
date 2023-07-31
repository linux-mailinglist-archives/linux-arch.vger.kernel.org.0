Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4BD769D0C
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 18:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjGaQnu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 12:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbjGaQnr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 12:43:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004CE173F;
        Mon, 31 Jul 2023 09:43:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690821824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KxoZLuIb2LXdBWV1WMUhtUPeh5qwpd0tEBg8OxEPIVE=;
        b=NGUuyHtb5uPv+7hdDKaPR0sopI1XKlDRl9Ttyfw2sSonxjuG39OBiTKg2z+koF+pNxsM5y
        rV2byTktIF3L0Pb+dNUca8JxnhIjUAOQov6tiTD0vJpF9AA6BKQiiwE1pA3fsWzIaDwHpV
        /sSSHwAyUq1K25ND2CoLHSeyDSvHQTM1mYXTByOe29zdxNIQDqL0XhwNReTAMxZ+KwTvvu
        WtIIT8xwn4UFqsFws9jXjX1B8Vt1//mgpd3TsasS+1QbZTc8iwptgb4dRvHTfZb734QeX+
        /nex82NuZ9ZYcsjQMTQ038AfEHnbqUUAtoOZp1jsZwZfSCff+BwnT6ZRAYnzIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690821824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KxoZLuIb2LXdBWV1WMUhtUPeh5qwpd0tEBg8OxEPIVE=;
        b=bQmm1c70/wZKUGveXk4mP9PadN1sYeAkRVY0zcM7wDBo4jbnyTv5G+oFZajoBkzhGjgdbQ
        Fn+OUHkLBSdaqcDg==
To:     Peter Zijlstra <peterz@infradead.org>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 08/14] futex: Add flags2 argument to futex_requeue()
In-Reply-To: <20230721105744.230243724@infradead.org>
References: <20230721102237.268073801@infradead.org>
 <20230721105744.230243724@infradead.org>
Date:   Mon, 31 Jul 2023 18:43:44 +0200
Message-ID: <873514ni9r.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 21 2023 at 12:22, Peter Zijlstra wrote:
> In order to support mixed size requeue, add a second flags argument to
> the internal futex_requeue() function.

No user visible changes, right?

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

