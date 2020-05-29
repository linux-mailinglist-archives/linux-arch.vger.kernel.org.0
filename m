Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82E71E7482
	for <lists+linux-arch@lfdr.de>; Fri, 29 May 2020 06:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgE2EVC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 May 2020 00:21:02 -0400
Received: from ozlabs.org ([203.11.71.1]:42083 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbgE2EU1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 May 2020 00:20:27 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49YBF530k9z9sSs; Fri, 29 May 2020 14:20:25 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 41cd780524674082b037e7c8461f90c5e42103f0
In-Reply-To: <2e73bc57125c2c6ab12a587586a4eed3a47105fc.1585898438.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, airlied@linux.ie,
        daniel@ffwll.ch, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        keescook@chromium.org, hpa@zytor.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] uaccess: Selectively open read or write user access
Message-Id: <49YBF530k9z9sSs@ozlabs.org>
Date:   Fri, 29 May 2020 14:20:25 +1000 (AEST)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2020-04-03 at 07:20:51 UTC, Christophe Leroy wrote:
> When opening user access to only perform reads, only open read access.
> When opening user access to only perform writes, only open write
> access.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied to powerpc topic/uaccess, thanks.

https://git.kernel.org/powerpc/c/41cd780524674082b037e7c8461f90c5e42103f0

cheers
