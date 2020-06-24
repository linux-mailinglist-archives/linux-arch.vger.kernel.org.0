Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB66209728
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jun 2020 01:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbgFXXYM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 19:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729587AbgFXXYL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 19:24:11 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF993C061573;
        Wed, 24 Jun 2020 16:24:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z17so2746645edr.9;
        Wed, 24 Jun 2020 16:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MjT9jACDegh8i3/ldIssewU7scETwe65AzJWUVQFVO4=;
        b=l8h9jCUE+bZzZMyYcjgcio25dx7uVJNJRuIhNeauHNsnDfb5u4QxxzhxSkvI91E3GR
         YAeFRp8BmdzTAOYKQcVS8HQrY4xOVWMZbIVZ/IYcm6U+FV59rwH1iWuqZ8oaq3dw5SKY
         Kkoy0emu4qmSdIwlRK/W/jga+Py23jwSARfPu18nL+VaUNHWLBY2B75xDYdSq0inAIwX
         AbQDq0NVAemB+nsQPSCb0yWdIN/+Y3t6HaDpMoUB0dgAyI6fM1QLCinDReftAgCSyPdz
         S8sgtixPEagpvnz7gdJWRZ6F0OSWHzo0LXYRujrRyHLZ5Td8K9M2W4Vl/jloE8HzXrk3
         eeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MjT9jACDegh8i3/ldIssewU7scETwe65AzJWUVQFVO4=;
        b=nlyJx756zbgBHPQT9NJYCwYw4++07Hgx6WkijMERCOzIXnusfcGrJ6Qf8/sQcX6CR6
         zIskLoqyLg4k1LyimpSvpUOFuwqKSq9rCn7eJ/TK0h2wTx5G//alY+yMG5kLZszQqt7n
         lBmTUEm9cuQx5g5Ag50bMUHkEDsVYLgVgMg0skVwJ9368ggSd4EJnigLhIZDIQtT4zg8
         gKoEA9L5J1CITV6KbsQP6vvOIsfS8Q99Xvbt04Zu5CDnBIcFkgGNDzp1WDzbAFmspTWN
         UpoMqLEcL2mGGTTF/rSSGkm29bQbFr90F1RUUxJ01Yeu/wZmwM/1taGnPbmkDw2/aXVY
         tsCg==
X-Gm-Message-State: AOAM5332gdKHtbPOZhLTac4GkTVTvFG9tbvEJqrANIAs9hOImKLjwkUC
        VsU5VxmEcHfzL/0QEmx6W/wFFCQybE32clTk
X-Google-Smtp-Source: ABdhPJyLwHe+moQvFoRN9ZnTrDZ2zOH8S6VomM1fTNTwZtIHtwT6W0bunDPDMYGO+XnvxkGUsIYF4w==
X-Received: by 2002:a05:6402:3048:: with SMTP id bu8mr5833355edb.367.1593041049384;
        Wed, 24 Jun 2020 16:24:09 -0700 (PDT)
Received: from andrea (ip-213-220-210-175.net.upcbroadband.cz. [213.220.210.175])
        by smtp.gmail.com with ESMTPSA id o8sm7951828ejj.102.2020.06.24.16.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 16:24:08 -0700 (PDT)
Date:   Thu, 25 Jun 2020 01:24:02 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: LKMM patches for next merge window
Message-ID: <20200624232402.GA465543@andrea>
References: <20200624185400.GA13594@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624185400.GA13594@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 11:54:00AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> Here is the list of LKMM patches I am considering for the next merge
> window and the status of each.  Any I am missing or any that need to
> wait or be modified?
> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> 3ce5d69 docs: fix references for DMA*.txt files
> 	Could someone please provide an ack?

Fixing the N-th commit "move docs without updating in-tree references".
;-/

Most importantly there appears to be some on-going discussion about it,
cf.

  https://lkml.kernel.org/r/20200623072240.GA974@lst.de

(could you please sort this out?)

  Andrea


> 
> ac1a749 tools/memory-model: Add recent references
> be1ce3e tools/memory-model: Fix "conflict" definition
> 24dca63 Documentation: LKMM: Add litmus test for RCU GP guarantee where updater frees object
> 47ec95b Documentation: LKMM: Add litmus test for RCU GP guarantee where reader stores
> bb2c938 MAINTAINERS: Update maintainers for new Documentation/litmus-tests
> 05bee9a tools/memory-model: Add an exception for limitations on _unless() family
> dc76257 Documentation/litmus-tests: Introduce atomic directory
> d059e50 Documentation/litmus-tests/atomic: Add a test for atomic_set()
> 7eecf76 Documentation/litmus-tests/atomic: Add a test for smp_mb__after_atomic()
> 116f054 tools/memory-model: Fix reference to litmus test in recipes.txt
> ffd32d4 Documentation/litmus-tests: Merge atomic's README into top-level one
> a08ae99 Documentation/litmus-tests: Cite an RCU litmus test
> 843285eb tools/memory-model/README: Expand dependency of klitmus7
> 0296c57 tools/memory-model/README: Mention herdtools7 7.56 in compatibility table
> 47e4f0a Documentation/litmus-tests: Add note on herd7 7.56 in atomic litmus test
> 	All ready to go.
