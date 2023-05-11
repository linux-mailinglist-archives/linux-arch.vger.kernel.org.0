Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C12B6FF1D5
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 14:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbjEKMtc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 May 2023 08:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237779AbjEKMta (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 08:49:30 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4519C6E86;
        Thu, 11 May 2023 05:49:25 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id A028D2B069A3;
        Thu, 11 May 2023 08:49:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 11 May 2023 08:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1683809360; x=1683816560; bh=d2I3MJoGb9Q0k1pggTIspxukMh9F288HwWB
        EZkJydBM=; b=EaT8QDsGJiHFxT+LJIqn2fEflreLZWqKGpVDwbrPLYvL1wt4nLg
        Wa1WNW+6odEbrT8vWG4Kqkt+XnHCbupWK6S+GXNiSev5T5S8qdVptnwvrdvaaypO
        DxjOXrlGw3MTnH2SHlm0saVDo2Vd/MH+coOuqnxVibh+pIY7tCYKM91yc2+lwfAY
        8Uc2AImEQiSqaPkFH2OZMZZ6uXWu/+4L6TrxtkbPQuvAgmwNbIpat8dyWeE65WLr
        FepOVjK9s4dKMRV4F5hYmRYR+t6pmOJCCfLHN3yAKTmYYofcqSRReJX/58keVUGZ
        /qacxa7dNgui0WGS51SJYWw3o+gkd4E/o3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683809360; x=1683816560; bh=d2I3MJoGb9Q0k1pggTIspxukMh9F288HwWB
        EZkJydBM=; b=jB9XvrdWPUTvwh1iDY/3NDQnzSrog8ELb1h9L6ikkVOhDtmVDz3
        UXAE5Lfnsb1qGvgzMXsuGMtW7DAOXrZUF0n3em0sgcghRqYnzwQRhIBzcvAHtYIC
        dz7ZcosF3AQPao+lh5E5QQNhIUKMyozAL6w1I/BEh06mRkVMXxyIKxgQjVFOBQJs
        +qn35bkU+cxGHXhW0HPtsju+GE+7hIaFH7AtuAcdjCwDuIBXfwJgaXumToGqAG9v
        sbHIo24d/eBn7IIu6FJKuWDyuFr9H2c8qDhKBrLkmoqiDvXdpn6+vGeMFizRdU44
        I9XCsw3OdQRl8ibPdLeZecXx1RH0d+WvXTQ==
X-ME-Sender: <xms:TuRcZA4pAKPMmi7NEPfI-jLSQXmHRDtm7W6A9M2gFiJw_2zwTZ9fKA>
    <xme:TuRcZB4r0tClLPdVZMNorjPuw_9H3qKfjnEZHs0h_BMh80peLqqeNakHDRm_wYK_v
    C2p3s5VZ5IB8O7TQ28>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegkedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:TuRcZPenQXcfeUqmz-DfyRWxTt2mOy2jd9F75_W0kvLW9Zg0R_GJjg>
    <xmx:TuRcZFLacxJD9zWaXSC8lel2meoqhOP82JKYSavCgBWS3l9n_bXBbA>
    <xmx:TuRcZEJlVY3mEQHhFeaLrOMkszBMbmlk-SePu_RRbt-YzeFdA5a8jw>
    <xmx:UORcZBYC0UB6UD24jDdNcFRC8O72IQAijFL3Wl-pXlCc3rY08CNRqgVB5t4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A9369B60086; Thu, 11 May 2023 08:49:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <4976d32d-b73f-49e5-9e15-78786d77dc8f@app.fastmail.com>
In-Reply-To: <CAMuHMdVvR1jdbZS8KoMf4R3zhLRWKv9XbG61iBGOGGZPHB+taA@mail.gmail.com>
References: <20230510110557.14343-6-tzimmermann@suse.de>
 <202305102136.eMjTSPwH-lkp@intel.com>
 <f6b2d541-d235-4e98-afcc-9137fb8afa35@app.fastmail.com>
 <49684d58-c19d-b147-5e9f-2ac526dd50f0@suse.de>
 <743d2b1e-c843-4fb2-b252-0006be2e2bd8@app.fastmail.com>
 <CAMuHMdVvR1jdbZS8KoMf4R3zhLRWKv9XbG61iBGOGGZPHB+taA@mail.gmail.com>
Date:   Thu, 11 May 2023 14:48:58 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Thomas Zimmermann" <tzimmermann@suse.de>,
        "kernel test robot" <lkp@intel.com>,
        "Helge Deller" <deller@gmx.de>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Vineet Gupta" <vgupta@kernel.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "David S . Miller" <davem@davemloft.net>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Sam Ravnborg" <sam@ravnborg.org>, suijingfeng@loongson.cn,
        oe-kbuild-all@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        "Artur Rojek" <contact@artur-rojek.eu>
Subject: Re: [PATCH v6 5/6] fbdev: Move framebuffer I/O helpers into <asm/fb.h>
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 11, 2023, at 14:35, Geert Uytterhoeven wrote:
> CC Artur, who's working on HP Jornada 680.
>
> On Wed, May 10, 2023 at 5:55=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> On Wed, May 10, 2023, at 16:27, Thomas Zimmermann wrote:
>> > Am 10.05.23 um 16:15 schrieb Arnd Bergmann:
>> >> On Wed, May 10, 2023, at 16:03, kernel test robot wrote:
>
> See also commit 4aafae27d0ce73f8 ("sh: hd64461 tidying."), which
> claims they are no longer needed.
>
> Don't the I/O port macros just treat the port as an absolute base addr=
ess
> when sh_io_port_base isn't set?

As far as I can tell, sh_io_port_base gets initialized to '-1'
specifically to prevent that from working by accident. So it's
almost treated as an absolute base address, but the off-by-one
offset ensures this never actually works unless it was first
set to the correct value.

      Arnd
