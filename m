Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D3059AF92
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 20:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiHTS1X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Aug 2022 14:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiHTS1X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2022 14:27:23 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43287115;
        Sat, 20 Aug 2022 11:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=chrKz2qJ9ZkVm8OQeZzW+KP/glHbFy4cwS/hAIybqxw=; b=h9GWDRQRAWwDXEpRAVqCPxnx38
        3OtxrLRleFxajQuNuk6vKfxQu48IUmu14YSJi7p/JmQsV+88m479UFgZSxF4reH5OcPVRArukBOTk
        dAznMKmYBJWoyUf0z6rtIlNBN7GfisrHAw853XVf7TGtlOckWl+GSqfHjTtmZo/lex6WkCM3+z/nZ
        SICggJ9+kIcZxQ018/ppn6Z/xO8y0QyFB04FTsbklX8kKMcZOmMFtyNKWATOB81B+ZPa257OGOFSy
        9RozrF41BIK/7XdqWpDMNaN5mst7I05EL2WuNfRQpQ2DBkKD1nJIiDuNcCXxx5aAKp79s/xROk4rn
        s6SPGCjw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPTBo-006RmP-AP;
        Sat, 20 Aug 2022 18:27:20 +0000
Date:   Sat, 20 Aug 2022 19:27:20 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/7] termios: consolidate values for VDISCARD in INIT_C_CC
Message-ID: <YwEniFuQ7+dqXc5m@ZenIV>
References: <YwBWJYU9BjnGBy2c@ZenIV>
 <20220820033730.1498392-1-viro@zeniv.linux.org.uk>
 <20220820033730.1498392-4-viro@zeniv.linux.org.uk>
 <CAHk-=wgLzPq42K8w8M6u__p8fu-FbN6VwvhE3Vvu9n_Pb0kwUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgLzPq42K8w8M6u__p8fu-FbN6VwvhE3Vvu9n_Pb0kwUQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 20, 2022 at 11:01:26AM -0700, Linus Torvalds wrote:
> On Fri, Aug 19, 2022 at 8:37 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > However, util-linux still resets it to ^O on any architecture,
> > ^O is the historical value, kernel ignores it anyway and finally,
> > Linus said "Just change everybody to do the same, nobody cares
> > about VDISCARD".
> 
> Heh. Grepping for DISCARD_CHAR() shows that there literally doesn't
> seem to be any user.
> 
> I  guess some user space program could care what the initial value is,
> but it seems very unlikely.

	Quite, especially since those programs would have to run before
getty gets a chance to reset the sucker to ^O...
