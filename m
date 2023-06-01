Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EE47194C8
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 09:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjFAHyn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 1 Jun 2023 03:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjFAHwl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 03:52:41 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066EB1BF9;
        Thu,  1 Jun 2023 00:46:13 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1q4d0a-001zrK-5A; Thu, 01 Jun 2023 09:46:08 +0200
Received: from p57bd9d78.dip0.t-ipconnect.de ([87.189.157.120] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1q4d0Z-002wPt-St; Thu, 01 Jun 2023 09:46:08 +0200
Message-ID: <d0ab5473947004ab9f26a07784a2f122574b7a60.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 30/34] sh: Convert pte_free_tlb() to use ptdescs
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Date:   Thu, 01 Jun 2023 09:46:06 +0200
In-Reply-To: <CAMuHMdVx_0Dhz1fOsCr3aYAVpk1HypoPJwbdNDj3h08x4esu0g@mail.gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
         <20230531213032.25338-31-vishal.moola@gmail.com>
         <CAMuHMdU4t4ac_eCH0UaX9F+GQ5-9kYjB_=e+pSfTkxG=3b8DsA@mail.gmail.com>
         <025fc34a24e1a1c26b187f15dba86d382d9617eb.camel@physik.fu-berlin.de>
         <CAMuHMdVx_0Dhz1fOsCr3aYAVpk1HypoPJwbdNDj3h08x4esu0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.157.120
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2023-06-01 at 09:42 +0200, Geert Uytterhoeven wrote:
> Hi Adrian,
> 
> On Thu, Jun 1, 2023 at 9:28 AM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > On Thu, 2023-06-01 at 09:20 +0200, Geert Uytterhoeven wrote:
> > > On Wed, May 31, 2023 at 11:33 PM Vishal Moola (Oracle)
> > > <vishal.moola@gmail.com> wrote:
> > > > Part of the conversions to replace pgtable constructor/destructors with
> > > > ptdesc equivalents. Also cleans up some spacing issues.
> > > > 
> > > > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > > 
> > > LGTM, so
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > I assume this series is supposed to go through some mm tree?
> 
> I think so, so your Acked-by would be appreciated...

OK, I will have a look. Btw, can you have a look at the second series by
Artur ("SuperH DMAC fixes")? I haven't had the time for these yet, but
I will have time in the weekend.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
