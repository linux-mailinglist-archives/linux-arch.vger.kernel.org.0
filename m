Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA093DA065
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 11:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhG2Jjb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jul 2021 05:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236087AbhG2Jjb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Jul 2021 05:39:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F9116108B;
        Thu, 29 Jul 2021 09:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627551568;
        bh=KguAjYe1CPylIhLKM5L3ZgCIologciM8wJ5c7boSXR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DvZUmWaaNxa1vMxIlmvzLx3DdBhBUCqWMIfqPrT6ZUulKhj0Wb8jGDNCgP7UVOuji
         ljy/HIEH4sqTETfknCZBQDbOyOxj60BJ9/Elu37a8f6LYb78iOg9UXEVfJ7J3MqH4K
         YQPN32GVxa/6VB3vMXDnaZEBX/MQYAOBlKYqLtaltDhR6jHOtp5JEahjpPPyRkkcf2
         OxQ8igIvQrqhD3NokJZo/3oWpiykFR1H5DidxU0Rv73tXAhQBuFCrepLvuEVNz9M6Q
         5eUGnMOW3eWMJkoZm6WPrstnw8snnkJXcM09AK4cUl5Yy5f5EP78b1OTcKAhmpX3Qy
         yLgx9ClaVixKA==
Date:   Thu, 29 Jul 2021 10:39:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Rui Wang <wangrui@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, hev <r@hev.cc>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [RFC PATCH v1 1/5] locking/atomic: Implement atomic_fetch_and_or
Message-ID: <20210729093923.GD21151@willie-the-truck>
References: <20210728114822.1243-1-wangrui@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728114822.1243-1-wangrui@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 28, 2021 at 07:48:22PM +0800, Rui Wang wrote:
> From: wangrui <wangrui@loongson.cn>
> 
> This patch introduce a new atomic primitive 'and_or', It may be have three
> types of implemeations:
> 
>  * The generic implementation is based on arch_cmpxchg.
>  * The hardware supports atomic 'and_or' of single instruction.

Do any architectures actually support this instruction?

On arm64, we can clear arbitrary bits and we can set arbitrary bits, but we
can't combine the two in a fashion which provides atomicity and
forward-progress guarantees.

Please can you explain how this new primitive will be used, in case there's
an alternative way of doing it which maps better to what CPUs can actually
do?

Cheers,

Will
