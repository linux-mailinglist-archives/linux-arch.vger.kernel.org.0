Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F946A62EF
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 23:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjB1W5s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 17:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjB1W5r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 17:57:47 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2092F3644D;
        Tue, 28 Feb 2023 14:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HhC+CeDXQ7gPGIdMC9D+ydrQrRw7f5eYoVKO6gIUIQU=; b=b+bU0BwLdSlEPuAWTJxKPFliQs
        fF0uc0NeMyOv5FkV5ROv7Nzl5plJHwZ0DpMLWxztZCacserxJOGR6R9ne9u87Z89xpJj5bfxZrBal
        Fq+acpGv0JBaQ0OPzqoRWy6MsLcnK7QsuN48gwji5+uwNBNH+MVhuGyI8qjJ2dEaZ8JEwQpKrBBDW
        RfxudAhIyUSJrFpBZ+XUi2Phw3HJraptnTkUzSHlECOqeQWeCQCmXk1CiT8fmnAvEzUjS5l5FM+I/
        V4H0ERsZsIj5Y9U2fj9QnzFHNXjoGeqieL2VI9/VmCgRcEklVJ1Tq9O/nIE0GwWAtPEky9X0wv1pY
        6odKM55g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pX8uk-00CwCe-1I;
        Tue, 28 Feb 2023 22:57:42 +0000
Date:   Tue, 28 Feb 2023 22:57:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH 08/10] parisc: fix livelock in uaccess
Message-ID: <Y/6G5qCEKh68VOcQ@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV>
 <Y9l0w4M91DwYLO3N@ZenIV>
 <84b1c2e4-c096-ed19-9701-472b54a4890c@gmx.de>
 <Y/47PMmpLDX5lPWx@ZenIV>
 <e9972a0e-14e6-987c-fcee-005a50d28e46@gmx.de>
 <Y/5Sf3fXn0uOUXTw@ZenIV>
 <39436c4d-f5a2-edd5-24ba-19e4812ea364@gmx.de>
 <215b226f-7ffd-70d8-4e7b-85b37f288062@gmx.de>
 <2646c13f-33b8-1047-7cfe-bf7e394344b6@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2646c13f-33b8-1047-7cfe-bf7e394344b6@gmx.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 28, 2023 at 09:22:31PM +0100, Helge Deller wrote:

> Now I can confirm (with the adjusted reproducer), that your patch
> allows to kill the process with SIGKILL, while without your patch
> it's not possibe to kill the process at all.
> I've tested with a 32- and 64-bit parisc kernel.
> 
> You may add
> Tested-by: Helge Deller <deller@gmx.de> # parisc
> to the patch.
> 
> If you want me to take the patch (with the warning regarding missing msg variable fixed)
> through the parisc tree, please let me know.

What message do you prefer there?  It matters only for the case when
we are hitting an oops there, but...
