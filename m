Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313946A5D0D
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 17:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjB1Q0C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 11:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjB1Q0B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 11:26:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B17198D;
        Tue, 28 Feb 2023 08:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IgJ0EleCFg3su5svsEjIxOWjMFwN7SRHUtLfsnnNW5c=; b=sdAVUJ9KfI5PHWU6WUw5GPuE6f
        eilVdLFUjNzwCXvxLHYrMCgu/ZjKbAJwtfuiYUMF0WqmqzbVsoxl53yBoCub3t299qxpLf+uvw+pT
        tAkx0x9USJnQArUbXs4TwkERGaaTwK7z9Uojb61NpKMvguuU44lZ+asgLtpptLF0J2FoqqMdj0fCU
        IWofXCFryD0GtFUre3Keemt0eZ+TBZXao8vb5Epwsj/x/maHrBno01cjfYrWQZK3gjbKaDKt+AsFQ
        CgcnUrzAV9IW6WHJV5MK/ewk0/rWcXAeuhoAHezpGAGApoMM4BCGb7gB0JiJY1YkvuSFKqGwALQRo
        9a4McGig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pX2nO-000yNy-6J; Tue, 28 Feb 2023 16:25:42 +0000
Date:   Tue, 28 Feb 2023 16:25:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH v2 06/30] arc: Implement the new page table range API
Message-ID: <Y/4rBgumVbfvKA9X@casper.infradead.org>
References: <20230227175741.71216-1-willy@infradead.org>
 <20230227175741.71216-7-willy@infradead.org>
 <e62ebe27-a1f6-ebd5-9ee0-a78e14ec4d38@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e62ebe27-a1f6-ebd5-9ee0-a78e14ec4d38@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_NONE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 27, 2023 at 10:34:05PM -0800, Vineet Gupta wrote:
> You need to split ARC and ARM into separate patches.

Ugh.  Looks like I inadvertently squashed them together during a rebase.

c228f5b4e007 HEAD@{121}: rebase (reword): arm64: Implement the new page table ra
nge API
22744c8ae873 HEAD@{122}: rebase (fixup): arc: Implement the new page table range
 API
11da1e433338 HEAD@{123}: rebase (fixup): # This is a combination of 2 commits.
d68d7ab9b184 HEAD@{124}: rebase (start): checkout next-20230225

I was trying to fixup an arm commit and looks like i squashed the arm
commit with the arc commit instead.  Will fix and resend.

> Also it'd be best to drop all the VIPT aliasing bits for ARC, they are a
> needless maintenance burden.
> I can send a patch which you could carry in your tree for easier logistics.

Works for me!  I don't mind if you want to drop the VIPT bits before
or after my changes; I can adapt to either.  Thanks
