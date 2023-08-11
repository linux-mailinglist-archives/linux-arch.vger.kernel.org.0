Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB437791CD
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 16:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbjHKO07 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 10:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbjHKO06 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 10:26:58 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3938B30C8;
        Fri, 11 Aug 2023 07:26:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id DAF7B3200918;
        Fri, 11 Aug 2023 10:26:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 11 Aug 2023 10:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691764015; x=1691850415; bh=FP
        +WVqD4FWw/1GEA6CcYKtr0HgvONb8SncErIfqh1+g=; b=DJtxgYEDfYvGa1fJTF
        Nm7EXNZMwhpC4FXqSPoDRPGx9dzcAVhJfVOE7cdz4DKxI6qz7ous8YB4GwD1Nz8I
        xA0L6Sx9i1RD9NHG4grDbmMCBeFfkuou3UvhViPJhENaDpTD0LYHH9YZfeGuTadv
        8MyeBe5d50SRr9+7N6ySJqkeNR4ySTkKaDxTaKAOV8Q0psLcDnuIOxU9zlwQ2gOv
        uWu6/tL4QmdDA3Jc6/O3jGLyIzn/Y9rs97O72v+YZYjn1LzAGJWbc56ltIs6BCfj
        fzmzgySVgcQYgU/jzEvcMj8Q3q07XDLnPshQTPyT26ABJwC91IJEC4y4rInF27Cj
        t26A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691764015; x=1691850415; bh=FP+WVqD4FWw/1
        GEA6CcYKtr0HgvONb8SncErIfqh1+g=; b=pKWFoDJDyfEhdBFi/1kKATeuIQ70I
        s7Sd4dSp3eP6hCNuj2jCsgWg4vrCL8cPjxDUIsdQBRUJOOJ8LRYgIEuVRFaAz7wH
        sct4EKVxgPMuVX+fpLhybHnmxDlEOuS1H6tOOHGvTYhikbro84+zzkZRZZOqafUj
        uZtl0xnW1E6lpxG2dIYVR5HQYIgebMH0nJZDYembMKuTBIv7uwhhJAfn7p4TDljr
        HrT6kcsVVl1/v7XZOo2FngrZGiClbWCP1o9yAHGaf+3h+ZCT6DjmYLBlVcspgwo9
        3B5TrUhElPgUgnxfPICwAceCgipS7l65FEBPd996smlnMZeT8VVbuQg5w==
X-ME-Sender: <xms:LkXWZN3y0UPCkiStVZQvmlZf7zlULIgqntOME-Gee7gKDUP5dgkYBg>
    <xme:LkXWZEESSVJ8FvnOS-vRFxt3BzHO6tLCMheZzOkMAtWGoMIlr0xoygEDg257jjLAh
    QNIfr58PJWGXw8FjQo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleekgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:LkXWZN6Dz9id3rwOOl-qCTzBcv_kNLAGfuWCsoaw4lvhyTFFoOUakg>
    <xmx:LkXWZK0FYBrPLk10iLG3u5n51cXXUt7BFuNYZFeUXuykanzmX2COrg>
    <xmx:LkXWZAGdu_39WSQtJIou9qKEh6L5U4HA5OT198XGrB_qosvB_LHgcg>
    <xmx:L0XWZL2ujw4Bym2NWrOM_4mLLf8pxTxrGtxudiIro2VABl91-iPrEA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DC2D6B60089; Fri, 11 Aug 2023 10:26:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <6e1c3faf-83f3-4627-bd74-42fea5b88dfb@app.fastmail.com>
In-Reply-To: <20230811141943.GB3948268@dev-arch.thelio-3990X>
References: <20230811140327.3754597-1-arnd@kernel.org>
 <20230811140327.3754597-3-arnd@kernel.org>
 <20230811141943.GB3948268@dev-arch.thelio-3990X>
Date:   Fri, 11 Aug 2023 16:26:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nathan Chancellor" <nathan@kernel.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Masahiro Yamada" <masahiroy@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        "Guenter Roeck" <linux@roeck-us.net>, "Lee Jones" <lee@kernel.org>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 2/9] Kbuild: consolidate warning flags in
 scripts/Makefile.extrawarn
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 11, 2023, at 16:19, Nathan Chancellor wrote:
> On Fri, Aug 11, 2023 at 04:03:20PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> Warning options are enabled and disabled in inconsistent ways and
>> inconsistent locations. Start rearranging those by moving all options
>> into Makefile.extrawarn.
>> 
>> This should not change any behavior, but makes sure we can group them
>> in a way that ensures that each warning that got temporarily disabled
>> is turned back on at an appropriate W=1 level later on.
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  Makefile                   | 88 -------------------------------------
>>  scripts/Makefile.extrawarn | 90 ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 90 insertions(+), 88 deletions(-)
>
> This shuffle seems reasonable to me. Would it make sense to rename the
> Makefile from Makefile.extrawarn to just Makefile.warn or
> Makefile.warnings? They are still "extra" warnings but to me, the
> meaning of the Makefile is changing so it seems reasonable to drop the
> "extra" part.

Renaming the file seems fine, but I'd much prefer to do that separately
if we decide to do it, otherwise rebasing my patches is going to
be even more painful.

     Arnd
