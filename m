Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEFE6A5F69
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 20:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjB1TOO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 14:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjB1TOK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 14:14:10 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD5930B22;
        Tue, 28 Feb 2023 11:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/DfylIog33+Qyw74IFy/XwS8sH7GAuj7lahu5SxrkPA=; b=NihVpnCusHMc4QvoyemSpX2pr5
        nfKAD1n43Rg9bnd660JGOBnZsOZ8+3SRDSg5LCXe9JMUjdYYGax6B0E8lHl0/MPU7bsO8qwE5NzkZ
        VlyqYgWR0Pgn2vUju5fbF5+CLBa+mACbUm3YH029VrZbMBWGeoQA4BmEoVf2BkoCkLniti8kwC7Zn
        EDs3VCx1l6CGNxoenN2QiaEplPDQ9V71hsEf0bsGlo57R3WmVu/aNAiituZOer4w/Zgp9P6UNL7IG
        VpEANsBkK1MFeVOYa5+zyX5R/gVe5afXDe36LUg0Fmmh6AaPAQ8bwoz2Mv0sDv23YfL1O0Xbdi2w6
        H/p6D6Bw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pX5QN-00CuHW-1O;
        Tue, 28 Feb 2023 19:14:07 +0000
Date:   Tue, 28 Feb 2023 19:14:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH 08/10] parisc: fix livelock in uaccess
Message-ID: <Y/5Sf3fXn0uOUXTw@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV>
 <Y9l0w4M91DwYLO3N@ZenIV>
 <84b1c2e4-c096-ed19-9701-472b54a4890c@gmx.de>
 <Y/47PMmpLDX5lPWx@ZenIV>
 <e9972a0e-14e6-987c-fcee-005a50d28e46@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9972a0e-14e6-987c-fcee-005a50d28e46@gmx.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 28, 2023 at 07:26:48PM +0100, Helge Deller wrote:

> I can test both parisc32 and parisc64.
> 
> > 	Just to confirm: your "can be killed with ^C" had been on the
> > mainline parisc kernel (with userfaultfd enable, of course, or it wouldn't
> > hang up at all), right?
> 
> It was a recent mainline kernel with your patch.

Er...  Reproducer *is* supposed to block; the bug is that on the kernel
without this patch it would (AFAICS) be impossible to kill - not even
with kill -9.  With bug fixed the behaviour should be "blocks and is
killable", i.e. what you've reported.

What does it do on unpatched kernel?  *IF* the big is there, it would
block and be unkillable by any means.  Could you verify that?
