Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B844B10D974
	for <lists+linux-arch@lfdr.de>; Fri, 29 Nov 2019 19:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfK2SMA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Nov 2019 13:12:00 -0500
Received: from gentwo.org ([3.19.106.255]:39528 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbfK2SMA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Nov 2019 13:12:00 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id ED6833EF26; Fri, 29 Nov 2019 18:11:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id EB5E33EA25;
        Fri, 29 Nov 2019 18:11:59 +0000 (UTC)
Date:   Fri, 29 Nov 2019 18:11:59 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
cc:     Dennis Zhou <dennis@kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] fix __percpu annotation in asm-generic
In-Reply-To: <20191127225432.ttwxm3hxtg5utfaz@ltop.local>
Message-ID: <alpine.DEB.2.21.1911291808530.1365@www.lameter.com>
References: <20191126200619.63348-1-luc.vanoostenryck@gmail.com> <alpine.DEB.2.21.1911271553560.16980@www.lameter.com> <20191127175350.GA52308@dennisz-mbp.dhcp.thefacebook.com> <20191127225432.ttwxm3hxtg5utfaz@ltop.local>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 27 Nov 2019, Luc Van Oostenryck wrote:

> 1) it would strip any address space, not just __percpu, so:
>    it would need to be combined with __verify_pcpu_ptr() or,
>    * a better name should be used,

typeof_cast_kernel() to express the fact that it creates a kernel pointer
and ignored the attributes??

>    * it should be defined in a generic header, any idea where?

include/linux/compiler-types.h

> 2) while I find the current solution:
> 	typeof(T) __kernel __force *ptr = ...;

It would be

   typeof_cast_kernel(&T) *xx = xxx

or so?

