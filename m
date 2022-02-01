Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252174A57F7
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 08:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiBAHm6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 02:42:58 -0500
Received: from verein.lst.de ([213.95.11.211]:57784 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229975AbiBAHm6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Feb 2022 02:42:58 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 81C9A68AA6; Tue,  1 Feb 2022 08:42:54 +0100 (CET)
Date:   Tue, 1 Feb 2022 08:42:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Guo Ren <guoren@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 1/5] uapi: remove the unused HAVE_ARCH_STRUCT_FLOCK64
 define
Message-ID: <20220201074254.GB29119@lst.de>
References: <20220131064933.3780271-1-hch@lst.de> <20220131064933.3780271-2-hch@lst.de> <CAJF2gTTjj8DXByP44DsC47xB2W_88j5Qp7TyEnRQCfUvHQUixA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTjj8DXByP44DsC47xB2W_88j5Qp7TyEnRQCfUvHQUixA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 01, 2022 at 09:16:27AM +0800, Guo Ren wrote:
> Right?
> 
> Seems you've based on an old tree, right?

This was a fairly recent Linus tree.  I don't have the tree at hand
right now due to travel, but what changed there recently?
