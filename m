Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E1319DCBA
	for <lists+linux-arch@lfdr.de>; Fri,  3 Apr 2020 19:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403831AbgDCR1e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Apr 2020 13:27:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37964 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgDCR1e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Apr 2020 13:27:34 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKQ5j-009k01-D3; Fri, 03 Apr 2020 17:26:51 +0000
Date:   Fri, 3 Apr 2020 18:26:51 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie,
        daniel@ffwll.ch, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and
 user_write_access_begin/end
Message-ID: <20200403172651.GJ23230@ZenIV.linux.org.uk>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk>
 <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
 <20200402175032.GH23230@ZenIV.linux.org.uk>
 <202004021132.813F8E88@keescook>
 <20200403005831.GI23230@ZenIV.linux.org.uk>
 <20200403112609.GB26633@mbp>
 <20200403133719.GC25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403133719.GC25745@shell.armlinux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 03, 2020 at 02:37:19PM +0100, Russell King - ARM Linux admin wrote:

> > I think uaccess_enable() could indeed switch the kernel domain if
> > KERNEL_DS is set and move this out of set_fs(). It would reduce the
> > window the kernel domain permissions are overridden. Anyway,
> > uaccess_enable() appeared much later on arm when Russell introduced PAN
> > (SMAP) like support by switching the user domain.
> 
> Yes, that would be a possibility.  Another possibility would be to
> eliminate as much usage of KERNEL_DS as possible

That's definitely worth doing, but that's another long-term project ;-/

> - I've just found
> one instance in sys_oabi-compat.c that can be eliminated (epoll_ctl)
> but there's several there that can't with the current code structure,
> and re-coding the contents of some fs/* functions to work around that
> is a very bad idea.  If there's some scope for rejigging some of the
> fs/* code, it may be possible to elimate some other cases in there.

Well, your do_locks() definitely can be converted.  epoll_wait()...
not sure, need to look into that.  Is that about the layout mismatch
between struct oabi_epoll_event and struct epoll_event?  In case of
semtimedop...  Hell knows, I would probably consider moving that thing
into ipc/sem.c under ifdef...
