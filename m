Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DF27117FC
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 22:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbjEYUUi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 16:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjEYUUi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 16:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3249B;
        Thu, 25 May 2023 13:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E722C64A74;
        Thu, 25 May 2023 20:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D613BC433D2;
        Thu, 25 May 2023 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685046036;
        bh=TRdhRXxXUIYfs640uIn+I4Rf6UAXCv8idpkcYdsSebM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oiC2XGhNWUAmWE7pr8r3QtJ9JQsEo/jXvve3lXs2r5Y+W4R2mTSVXer6rhbIqd0H3
         uoSQkJ728HLdXkJmf2eWWiJHTRm/fGQOsi2eZMGN8iMwau2U+ioJb0W4RoKYGYtykh
         z9scTeHJfdOUnqeX313qP2xIMkwidI5DxymtOtruiJkZ/HiGGdvi3+NdefCU8HC/4L
         yVF6ukcziPPo5ghUZkvreoJAGRzTQdLIctyd1RS1O+YIm3/yAJVKFl1SAT+U6nvVPE
         TUmcZj1oUZgh7b4Odb9/HzteZyqvh1+JrTl0ADJm08qL98dpyZZ8OeR78PQJMngFPN
         0x/EvMWBkU0Qw==
Date:   Thu, 25 May 2023 23:20:11 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Vishal Moola <vishal.moola@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 01/34] mm: Add PAGE_TYPE_OP folio functions
Message-ID: <20230525202011.GZ4967@kernel.org>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-2-vishal.moola@gmail.com>
 <20230525085555.GV4967@kernel.org>
 <CAOzc2pxx489C26NnS9NHkUQY9PYiagzt-nYK6LnkJ1N3NYQWzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOzc2pxx489C26NnS9NHkUQY9PYiagzt-nYK6LnkJ1N3NYQWzg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 25, 2023 at 10:00:23AM -0700, Vishal Moola wrote:
> On Thu, May 25, 2023 at 1:56 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > Hi,
> >
> > On Mon, May 01, 2023 at 12:27:56PM -0700, Vishal Moola (Oracle) wrote:
> > > No folio equivalents for page type operations have been defined, so
> > > define them for later folio conversions.
> >
> > Can you please elaborate why would we need folios for page table descriptors?
> 
> Thanks for the review!
> 
> These macros are for callers that care about the page type, i.e. Table and
> Buddy. Aside from accounting for those cases, the page tables don't use folios.
> These are more for the cleanliness of those callers.

But why using folio APIs for PageType will be cleaner than using page APIs?
Do you have an example?

-- 
Sincerely yours,
Mike.
