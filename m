Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E748F769BDC
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 18:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjGaQIS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 12:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGaQIS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 12:08:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E77A7;
        Mon, 31 Jul 2023 09:08:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690819695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+0nZDc7AkOYPa1mOccvDg657HcpzyBZSpAOhgeEprOM=;
        b=kQiAjQGJ9PCeNdSRPe5w5zZZ+tsiqfczzWbMsKWzmIzNTMM02FDMXpzVOyl2zRTJVVs8M2
        URGIxv87b+gOpCIJ6Y348bNO8+LXt97sXxKLvQa1l4Oe3afFm+by2PxPqMIsDJJUiIduLx
        tHItUiTsMqJGTLsdOuFN7ojmScUu+Cu3HRPrNSCj6mr2ASjMPesCPd2qcd8ZqXFxYxTAJ1
        VMfsoauJZuuxjjWwTq8B7d7LkSyJv/FhpUAwDaXPuWCJpKOtf1D/eHrGn0aKD54o6Ib/ZW
        cyL6hBosji1kOglmWO5j7Ypb//w2mpPYIwhTWKQ0drQW1c9tCtJ0OAA8grU0cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690819695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+0nZDc7AkOYPa1mOccvDg657HcpzyBZSpAOhgeEprOM=;
        b=5kIZ0r+H+aqRKB9BE/XX7G1AER5gHoEZqVGWnb/wMhd98/2fnWrr0ZtYLGcZ+9tMXKRf39
        q0AP+fsSkjf/5uBA==
To:     Peter Zijlstra <peterz@infradead.org>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 01/14] futex: Clarify FUTEX2 flags
In-Reply-To: <20230721105743.751364377@infradead.org>
References: <20230721102237.268073801@infradead.org>
 <20230721105743.751364377@infradead.org>
Date:   Mon, 31 Jul 2023 18:08:15 +0200
Message-ID: <87h6pknjww.ffs@tglx>
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

ROn Fri, Jul 21 2023 at 12:22, Peter Zijlstra wrote:
> sys_futex_waitv() is part of the futex2 series (the first and only so
> far) of syscalls and has a flags field per futex (as opposed to flags
> being encoded in the futex op).
>
> This new flags field has a new namespace, which unfortunately isn't
> super explicit. Notably it currently takes FUTEX_32 and
> FUTEX_PRIVATE_FLAG.
>
> Introduce the FUTEX2 namespace to clarify this
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
