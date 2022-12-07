Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FF86463FB
	for <lists+linux-arch@lfdr.de>; Wed,  7 Dec 2022 23:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiLGWUT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Dec 2022 17:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiLGWUO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Dec 2022 17:20:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F946E543
        for <linux-arch@vger.kernel.org>; Wed,  7 Dec 2022 14:20:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DE61B820EA
        for <linux-arch@vger.kernel.org>; Wed,  7 Dec 2022 22:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D60C433C1;
        Wed,  7 Dec 2022 22:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670451609;
        bh=p2z6S6z2YCWdPDkYxobih1tXJlCEaFlC1U59vvIde+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bjUZQGYSTzRCdEGZk0t4alqFaoJYIgJQnNMU8BnrBOZg9EfxPOjTIrvOg2ZiszRXR
         ZR6uKWBUXXy56p2epTbCvkTpQo2c6vLSQFqED4pM+ScYoP8jgiLsMb+9smi3OK9lre
         r+gM3gbR5zbbq93+AhlNZxFbu6mGj9iFi5ir6I/E=
Date:   Wed, 7 Dec 2022 14:20:08 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        kernel test robot <yujie.liu@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Subject: Re: [linux-next:master] [mm] 5df397dec7:
 will-it-scale.per_thread_ops -53.3% regression
Message-Id: <20221207142008.e7251ad9f042ff2e89f4e866@linux-foundation.org>
In-Reply-To: <CAHk-=whkL5aM1fR7kYUmhHQHBcMUc-bDoFP7EwYjTxy64DGtvw@mail.gmail.com>
References: <202212051534.852804af-yujie.liu@intel.com>
        <CAHk-=wg330wAAxwSaJBPUtL5Rrn7PoQK3ksJw2OLvBxA0NGg+g@mail.gmail.com>
        <87ilipffws.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAHk-=wjDzVL+r6NmnU--tyEfDYhUB-5m=PQBZTQ2Es8bx7Mz+w@mail.gmail.com>
        <CAHk-=whjis-wTZKH20xoBW3=1qyygYoxJORxXx8ZpJbc6KtROw@mail.gmail.com>
        <878rjj22mz.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAHk-=whkL5aM1fR7kYUmhHQHBcMUc-bDoFP7EwYjTxy64DGtvw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 7 Dec 2022 12:17:47 -0800 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Andrew, here's the patch with a proper commit message. Note that my
> commit message contains the SHA1 of the original patch both in the
> explanation and in a "Fixes:" line, which I think is fine for the
> "mm-stable" branch that the original patch is in.
> 
> But if you end up rebasing that mm-stable branch, then I'd ask you to
> either remove/update those commit hashes, or just fold this fix into
> the original one. Ok?

Sure.

mm-stable is supposed to be non-rebasing.  I've snuck in a rebase a
couple of times early in -rc windows, but a rebase at -rc8 would
require quite a calamity.

