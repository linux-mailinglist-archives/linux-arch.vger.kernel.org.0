Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B340674E653
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 07:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjGKF2l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jul 2023 01:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGKF2j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2023 01:28:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E4F134;
        Mon, 10 Jul 2023 22:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RXW4A+b1WPgXV4CxG4WnnSMOUoZ912ow27yCjm8WoHo=; b=JOC8ov9mbUl73be9JZXdbfYXRU
        OI0q4RBxAUA3iJha+PLQrb2wBF8I+UoEQDzUroNieUAoDDS5L3MHJ5E8x4PH59RPUWIlKoGUFUTEk
        W8Z4B99ZlsK70bo/a4VMrp+nfkC2kmX6mry7HXoKUDvFRIZf50S+GhBFLsIRtp0qmPSSDru6Ww34N
        G4VWCsY9ZjEOJrXsfPn0m6BnRJE5Nj3zKrmR/fTQOJ2FwH/n986jdd5g4/OjLPB8Fkei5hQPUwy/F
        IeuSSVsxBV9RqV2htneiMyY4xbsg5G/qFQ548iDEOAoxYtoATaDSXjXjqKUdgb5RDOWnLGrYU0pVE
        EA8u0gOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJ5vR-00Dkpe-1g;
        Tue, 11 Jul 2023 05:28:37 +0000
Date:   Mon, 10 Jul 2023 22:28:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/38] minmax: Add in_range() macro
Message-ID: <ZKzohY64KzvT6Xlq@infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
 <20230710204339.3554919-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710204339.3554919-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 10, 2023 at 09:43:02PM +0100, Matthew Wilcox (Oracle) wrote:
> Determine if a value lies within a range more efficiently (subtraction +
> comparison vs two comparisons and an AND).  It also has useful (under
> some circumstances) behaviour if the range exceeds the maximum value of
> the type.

Should this also drop existing versions of in_range()?  E.g. btrfs
already has its own.
