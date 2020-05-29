Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA791E747F
	for <lists+linux-arch@lfdr.de>; Fri, 29 May 2020 06:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgE2EUn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 May 2020 00:20:43 -0400
Received: from ozlabs.org ([203.11.71.1]:49311 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbgE2EU2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 May 2020 00:20:28 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49YBF610M2z9sSw; Fri, 29 May 2020 14:20:26 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b44f687386875b714dae2afa768e73401e45c21c
In-Reply-To: <ebf1250b6d4f351469fb339e5399d8b92aa8a1c1.1585898438.git.christophe.leroy@c-s.fr>
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
Subject: Re: [PATCH v2 3/5] drm/i915/gem: Replace user_access_begin by user_write_access_begin
Message-Id: <49YBF610M2z9sSw@ozlabs.org>
Date:   Fri, 29 May 2020 14:20:25 +1000 (AEST)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2020-04-03 at 07:20:52 UTC, Christophe Leroy wrote:
> When i915_gem_execbuffer2_ioctl() is using user_access_begin(),
> that's only to perform unsafe_put_user() so use
> user_write_access_begin() in order to only open write access.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied to powerpc topic/uaccess, thanks.

https://git.kernel.org/powerpc/c/b44f687386875b714dae2afa768e73401e45c21c

cheers
