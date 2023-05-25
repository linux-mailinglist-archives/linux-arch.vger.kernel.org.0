Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAC27103A4
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 06:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbjEYEEs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 00:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbjEYEEC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 00:04:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEF7E44;
        Wed, 24 May 2023 21:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KuZ2KYM2jWDD/OX38Fvk42dRb2v8pjevr29ZRoRBdOE=; b=QSth0rOsvPstkMxGf0N/W1fbCv
        fxciovskUNtLVdGWzlapH3lg1mlld7V5A55e0oNPXGtuY21XegqQFwQ2ErBlYfyaJW/+V1vA9XzJY
        4EyQ/6TTYVfXsATxcyUXsVNUkbPZeiLRNtfKoZ1u1+FybgaHOJpkDX4O/c+aE/GZwHO5mhsRwTMC+
        yUe303M/vscxDYFCRbCALvPSxlMf/oWGvny7Fw7ZqDqDTmrb1NubMAhXzVDd+A+qIVHPAelTz811R
        dLEGrWEhlPV6Q1Pnd5MBi6sEfGpKLA/wildizYmbjXtXlcJL9S4yyCUpTBrMpENKcwDT7/MoVpErI
        dlBgEGNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q22Cg-00BpFW-B2; Thu, 25 May 2023 04:03:54 +0000
Date:   Thu, 25 May 2023 05:03:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 29/36] mm: Remove page_mapping_file()
Message-ID: <ZG7eKgwn8LHsOn+I@casper.infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-30-willy@infradead.org>
 <f428a035-4728-1007-e0d5-97988ffe33cc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f428a035-4728-1007-e0d5-97988ffe33cc@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 25, 2023 at 09:20:47AM +0530, Anshuman Khandual wrote:
> 
> 
> On 3/15/23 10:44, Matthew Wilcox (Oracle) wrote:
> > This function has no more users.
> 
> On v6.4-rc3, there are still some users. Am I looking into a wrong
> tree/branch/tag ?

Did you apply patches 1-28 before grepping?
