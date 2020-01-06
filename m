Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB97130C75
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2020 04:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgAFDNl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Jan 2020 22:13:41 -0500
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:44264 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727369AbgAFDNl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Jan 2020 22:13:41 -0500
X-Greylist: delayed 1661 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Jan 2020 22:13:40 EST
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id 0062hOig061663;
        Mon, 6 Jan 2020 10:43:24 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 0062gfv8061600;
        Mon, 6 Jan 2020 10:42:41 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 6 Jan 2020
 10:45:15 +0800
Date:   Mon, 6 Jan 2020 10:45:16 +0800
From:   Alan Kao <alankao@andestech.com>
To:     <guoren@kernel.org>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <Anup.Patel@wdc.com>,
        <vincent.chen@sifive.com>, <zong.li@sifive.com>,
        <greentime.hu@sifive.com>, <bmeng.cn@gmail.com>,
        <atish.patra@wdc.com>, <linux-arch@vger.kernel.org>,
        <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <linux-csky@vger.kernel.org>, Guo Ren <ren_guo@c-sky.com>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 2/2] riscv: Add vector ISA support
Message-ID: <20200106024515.GA1021@andestech.com>
References: <20200105025215.2522-1-guoren@kernel.org>
 <20200105025215.2522-2-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200105025215.2522-2-guoren@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 0062gfv8061600
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Guo,

On Sun, Jan 05, 2020 at 10:52:15AM +0800, guoren@kernel.org wrote:
> From: Guo Ren <ren_guo@c-sky.com>
> 
> The implementation follow the RISC-V "V" Vector Extension draft v0.8 with
> 128bit-vlen and it's based on linux-5.5-rc4.
> 

According to https://lkml.org/lkml/2019/11/22/2169, in which Paul has stated
that "we plan to only accept patches for new modules or extensions that have
been frozen or ratified by the RISC-V Foundation."

Is v0.8 ratified enough for now?

