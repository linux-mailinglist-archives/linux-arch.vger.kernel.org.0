Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4561448BDAF
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jan 2022 04:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350188AbiALDdE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jan 2022 22:33:04 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:39125 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236491AbiALDdD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jan 2022 22:33:03 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id CCC045804D8;
        Tue, 11 Jan 2022 22:33:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 11 Jan 2022 22:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=KpXhp9
        XTu8lwVK5H01maepw6Nj9bWZ/sx97aGJpB0yQ=; b=LfgvCkg8/dRmYEwvmAeZGp
        PQAEsrmVyD/+7kZdPG7sdiBj8xdhEMVroxC13O+MEJ3oEwf7kKScYdp5h1tXT8K5
        8yKtZiF0PKk0ymZ+PBxgOaVEWXS+PGOQnlA04zlzdLCAAThLNIze+5bERwO1bzZ7
        ynoKvq2SbIA7H5acN0Gb6jG6BBRAnoOGjoeOSNeYBhMT7d1S2LFf6mr8aiEf/iVv
        N7zuL8kym9Jdea9EuaMC3Vg59+7x5suFsxoyBZt3p4kEKXZg3Y75jEPx5DOG38hK
        lGFPBwmBVTClVLtW3BVqSJiYLjRnNXDBAqqqf2GmS3q5X3Hd7MrXwUt/IZKYreAg
        ==
X-ME-Sender: <xms:7kveYd1WWXiI-mr_bVzYIvTmi-TZEKqcavnCE93Cqmc7GNk-7h1ObQ>
    <xme:7kveYUGmxoOkDqOY4YhzwnfLHxcpJpXj23XPKgeyvv_i9yw9xJIScn_BvBRNAAeVW
    LQZMhRxQR9Tqnpnb4I>
X-ME-Received: <xmr:7kveYd6HPy6M2E6NYHjz-MJM_RoSk8aaTAMqAGZ_5mVQyfXSqucuXN-uYgghvppHjjOCUlGi0gT_v9HV9lHmanWXsmmBGc0txL4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudehgedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepffduhfegfedvieetudfgleeugeehkeekfeevfffhieevteelvdfhtdevffet
    uedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:7kveYa25qc4SjmTh-loKAwcZuCzl1pnxeLOVCnj8EIGThoK9K3qp9w>
    <xmx:7kveYQFB1eias7arLJM9_mg5cbHYaT9yaMs0h_vB75Cg9oa4gbjCKg>
    <xmx:7kveYb8vBgfZghSheOJe7ppc20Hoj_dejM5udxUNsuJF6-guJlZXhQ>
    <xmx:7kveYeYjeEXGPCURsARWqnszLyA0Mc-9SUAR-mgCn9CxfUyjKdGvgQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jan 2022 22:32:59 -0500 (EST)
Date:   Wed, 12 Jan 2022 14:32:51 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH 08/17] ptrace/m68k: Stop open coding
 ptrace_report_syscall
In-Reply-To: <6060f799-d0c5-e4c2-a81c-2bd872ce3d5a@gmail.com>
Message-ID: <b8ad3fc-523f-eca2-91d7-c77d20a1e876@linux-m68k.org>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org> <20220103213312.9144-8-ebiederm@xmission.com> <CAMuHMdWsNBjOJh0QEx9sppA9x3WoL8H2icqukNqECFhOPremjw@mail.gmail.com> <YdxcszwEslyQJSuF@zeniv-ca.linux.org.uk> <CAMuHMdX9nhUQe_jeQCUtXeQgcQ5MBiHpPiRexh86EssoHNtJ3Q@mail.gmail.com>
 <acf7b627-2dec-c76c-2aa0-6b4c6addd793@gmail.com> <d660267-ce4f-e598-9b40-5cdbb4566c7@linux-m68k.org> <6060f799-d0c5-e4c2-a81c-2bd872ce3d5a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 12 Jan 2022, Michael Schmitz wrote:

> 
> I seem to recall we also tested those on your 040 and there was no 
> regression there, but I may be misremembering that.
> 

I abandoned that regression testing exercise when unpatched mainline 
kernels began failing on that machine. I'm in the process of setting up a 
different 68040 machine.
