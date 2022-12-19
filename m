Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E62B6510E2
	for <lists+linux-arch@lfdr.de>; Mon, 19 Dec 2022 18:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiLSRDd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Dec 2022 12:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiLSRDb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Dec 2022 12:03:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4E91086;
        Mon, 19 Dec 2022 09:03:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 442F961083;
        Mon, 19 Dec 2022 17:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051EDC433F1;
        Mon, 19 Dec 2022 17:03:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XMRa40qI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1671469407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IefjMF7tOMH0wax39/RLpi+AIb8VNuSkBwczTr3jg6k=;
        b=XMRa40qIaLchprvRhvNLCvBS530OrT6/v1C5KPpOPluQiOEVDkHZbWbUp4Wgb8X+xltoKG
        8u90rDBiULYuX+kPqz3Rs442oh5uOKN6U84shsRyDrWHkEM7TmqLiIdpAL6NSrWVZacxd3
        6guAoT8yiTi7sDMPVlOP4U3Bi9kJ7bo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 79318d9d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Dec 2022 17:03:27 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3b48b139b46so135030227b3.12;
        Mon, 19 Dec 2022 09:03:26 -0800 (PST)
X-Gm-Message-State: ANoB5pn4QngIirf/dIqawWvqMyN/ZdEWGRwobncjPB5ygGo6Xw9FCyY+
        O0Xpy50/CSsNSfpBYkv5DRnNKQQAQwld+Gj1CmM=
X-Google-Smtp-Source: AA0mqf56hSUvnp6sOH/4lCw8h7C5hUdYBXkDOQf8YsHAL5a33e68otGl2Xumid7SYgRvw7HIbTyPONVAqZXy7J7ezBw=
X-Received: by 2002:a0d:c6c3:0:b0:3f8:5b0b:bbb8 with SMTP id
 i186-20020a0dc6c3000000b003f85b0bbbb8mr14883107ywd.79.1671469396034; Mon, 19
 Dec 2022 09:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20221219153525.632521981@infradead.org> <20221219154118.889543494@infradead.org>
 <Y6CJsWBhcbKatZNg@zx2c4.com> <Y6CYu4skFFMopU+g@hirez.programming.kicks-ass.net>
In-Reply-To: <Y6CYu4skFFMopU+g@hirez.programming.kicks-ass.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 19 Dec 2022 18:03:04 +0100
X-Gmail-Original-Message-ID: <CAHmME9oCBgNCfYFxirA-fdarGip5MvOG-iUxT=2HC=iSXRMH-Q@mail.gmail.com>
Message-ID: <CAHmME9oCBgNCfYFxirA-fdarGip5MvOG-iUxT=2HC=iSXRMH-Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 01/12] crypto: Remove u128 usage
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 19, 2022 at 6:01 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Dec 19, 2022 at 04:56:33PM +0100, Jason A. Donenfeld wrote:
>
> > Why not just use `u128` from types.h in this file?
>
> Ordering, I can't very well introduce it in types.h while other
> definitions exist in the tree. So I first have to clean up the u128
> namespace.

Is there a patch at the end of the series that adds it back in to use u128?
