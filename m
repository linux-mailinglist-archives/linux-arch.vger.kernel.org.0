Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9C74B4310
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 08:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiBNHlj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 02:41:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiBNHlj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 02:41:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8705955480;
        Sun, 13 Feb 2022 23:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DfEeiuRA+O4zf/LvJNpGuXNN8ssOeWOmggzX3CeaHXM=; b=OObqb/wgIVNv915TVDxusBoMCU
        WJgQ/jeIAYMZgUoD6o2YTJ7Ox0of5patYEvusEixun7KO46JLZgyUr2MDxuWRGVLUmv90hrKpnAkV
        2XwC/ZzlOIuYIRzopQRpZAJgQcOs2Z29+r3gWpGvBq/x38Ebw0Ca2OKtwT0qp9OLyb7WcSyfg0K3f
        BRQ00zdULy0KGNC910SJNJZ/NVSYYB3+nnCUwA/llg4pFAzUhP0+xCHf+y7MdabynOIi/YuiSVqvd
        B/fGvR7RL2UDMHtSH6+jc5hyOgQqZt1hXvl0tEA3RXgrB3ByIfkgCKUcXvQKt+WnLfuF+Kur9lEXM
        bk8Qgotw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJVzA-00Dknm-OP; Mon, 14 Feb 2022 07:41:24 +0000
Date:   Sun, 13 Feb 2022 23:41:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Stafford Horne <shorne@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] microblaze: remove CONFIG_SET_FS
Message-ID: <YgoHpAG0GCdccLZF@infradead.org>
References: <CAK8P3a22ntk5fTuk6xjh1pyS-eVbGo7zDQSVkn2VG1xgp01D9g@mail.gmail.com>
 <20220117132757.1881981-1-arnd@kernel.org>
 <CAHTX3dKyAha8_nu=7e413pKr+SAaPBLp9=FTdQ=GZNdjQHW+zA@mail.gmail.com>
 <CAK8P3a2Om2SYchx8q=ddkNeJ4o=1MVXD2MFSV2SGJ_vuTUcp0Q@mail.gmail.com>
 <126ae5ee-342c-334c-9c07-c00213dd7b7e@xilinx.com>
 <CAK8P3a2zZfFa55nNeMicWHhia7fkT0cJBzYvUi0O+v0B13BOMA@mail.gmail.com>
 <YgROuYDWfWYlTUKD@antec>
 <YgWrFnoOOn/B3X4k@antec>
 <CAK8P3a0eAv168eepvdZQbYDstTQHc-Hb2_PMS3bseV3caB4oAA@mail.gmail.com>
 <CAHk-=wj7kOxDg+2Ym1EQsTZaZqU-p7aFHiNVOmtEhNS8jjapLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj7kOxDg+2Ym1EQsTZaZqU-p7aFHiNVOmtEhNS8jjapLQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 11, 2022 at 09:46:03AM -0800, Linus Torvalds wrote:
> Can you say why you didn't convert ia64? I don't see any set_fs() use
> there, except for the unaligned handler, which looks trivial to
> remove. It looks like the only reason for it is kernel-mode unaligned
> exceptions, which we should just turn fatal, I suspect (they already
> get logged).
> 
> And ia64 people could make the unaligned handling do the kernel mode
> case in emulate_load/store_int() - it doesn't look *that* painful.

Are there any ia64 people left? :)
