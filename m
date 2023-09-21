Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B527A9BAE
	for <lists+linux-arch@lfdr.de>; Thu, 21 Sep 2023 21:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjIUTDb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Sep 2023 15:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjIUTDI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2023 15:03:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F4866370;
        Thu, 21 Sep 2023 10:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/llZOvA5pbSYYCzF+/pB2v9yGKv4476j2xYxpeUurbc=; b=cmWCYaStuals415un9shDsQmvx
        /tyXtJ7fUE3ye6ShVRMExA4ffJhDkKuWsZqpBuWp3vRrw8iZi+9gT3c0jje53VL2+2L9OWbEWN/iw
        MmqhE8lqMAg20Md8GD4LkYL63qs+uEbdUeBsjoX3PAVVZ1NZw7ksTxBrJSgyj2HMqk9eV9ZkZnZ6t
        OFeWXOGgdp9CrLAYiEIBknPtmzV/hCw5YM9kwxYZZKEXKRzs6Zzc8pd7RLRqdo2swIgkSeo70knP3
        nIiC0X1X9bBn5ygg6X5A/MLnFjkVMQFK9CMSi2qHXRGu/BPfJoI49ltz2YE8JRd/I74R+c9+krcV6
        rGw16u+w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjI47-00FLi2-2S;
        Thu, 21 Sep 2023 11:41:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id D9D393002E3; Thu, 21 Sep 2023 13:41:52 +0200 (CEST)
Date:   Thu, 21 Sep 2023 13:41:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v3 15/15] futex,selftests: Extend the futex selftests
Message-ID: <20230921114152.GE14803@noisy.programming.kicks-ass.net>
References: <20230921104505.717750284@noisy.programming.kicks-ass.net>
 <20230921105249.214313438@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921105249.214313438@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 21, 2023 at 12:45:20PM +0200, peterz@infradead.org wrote:

> +#ifndef __NR_futex_wake
> +#define __NR_futex_wake 452
> +#define __NR_futex_wait 453
> +#define __NR_futex_requeue 454

Clearly I forgot to run the selftests before posting... +2 on those
syscall numbers.

Let me get on with writing some of that numa stuff.
