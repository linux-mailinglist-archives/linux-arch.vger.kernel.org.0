Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2191B6BA8F3
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 08:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjCOHXJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 15 Mar 2023 03:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjCOHWz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 03:22:55 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995F369237;
        Wed, 15 Mar 2023 00:22:41 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pcLT4-002bjm-Cw; Wed, 15 Mar 2023 08:22:38 +0100
Received: from p57bd9bc2.dip0.t-ipconnect.de ([87.189.155.194] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pcLT4-003hOw-3X; Wed, 15 Mar 2023 08:22:38 +0100
Message-ID: <892ce42a36bf1f1eac809f0e564d22b5f11c268f.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v4 23/36] superh: Implement the new page table range API
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Date:   Wed, 15 Mar 2023 08:22:36 +0100
In-Reply-To: <20230315051444.3229621-24-willy@infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
         <20230315051444.3229621-24-willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.155.194
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Matthew!

On Wed, 2023-03-15 at 05:14 +0000, Matthew Wilcox (Oracle) wrote:
> Add PFN_PTE_SHIFT, update_mmu_cache_range(), flush_dcache_folio() and
> flush_icache_pages().  Change the PG_dcache_clean flag from being
> per-page to per-folio.  Flush the entire folio containing the pages in
> flush_icache_pages() for ease of implementation.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org

I'm going to test this patch later today and report back.

In the meantime, could you change "superh" in the subject to "sh"?

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
