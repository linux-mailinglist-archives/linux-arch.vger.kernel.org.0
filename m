Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674A87A1EF0
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 14:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbjIOMn3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 08:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjIOMn2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 08:43:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05597115;
        Fri, 15 Sep 2023 05:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694781804; x=1726317804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mj5eYaq82hNMoxhsN8asXFIvsDdB/ZfUIlZ98+TAVAE=;
  b=kDWu16iIfEXfaS8kRU2y7II1nLJ8FCBaH7OO0AVFzX5LNSEoQO12JVHl
   9Gu4xJZFk///xONreH0G+IWXECAku+hpWM+DZoYaHHmbSSDdnkmiTgXqW
   L+qAGC2KyqTGqOZTgu5Ws//MwtC2D9us4b8+yAYJMIPLZgJDm53YXgfjw
   xkPZp0nHi7Ob46ppqml57lpqv6XrwfkMnpZUn50g7utNsx5pkCJE1yugt
   0KOBeEPWQPe2gc7POjHRbYE4MjEd+nvX4qoL4kuibXXlTjMgDErhpTpva
   Art9iTQ42BHcEEfg+J3OB/vtaWPZmCoA5DHsq7yZVlFLtSpFhp++qmy90
   Q==;
X-CSE-ConnectionGUID: nKAwje6qR/irJC6a9X1Kjw==
X-CSE-MsgGUID: WQwjx2uVRreZCbEqWFG2MQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="asc'?scan'208";a="4861527"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2023 05:43:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 15 Sep 2023 05:43:19 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 15 Sep 2023 05:43:13 -0700
Date:   Fri, 15 Sep 2023 13:42:56 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     Leonardo Bras <leobras@redhat.com>, <guoren@kernel.org>,
        <paul.walmsley@sifive.com>, <anup@brainfault.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
        <palmer@rivosinc.com>, <longman@redhat.com>,
        <boqun.feng@gmail.com>, <tglx@linutronix.de>, <paulmck@kernel.org>,
        <rostedt@goodmis.org>, <rdunlap@infradead.org>,
        <catalin.marinas@arm.com>, <xiaoguang.xing@sophgo.com>,
        <bjorn@rivosinc.com>, <alexghiti@rivosinc.com>,
        <keescook@chromium.org>, <greentime.hu@sifive.com>,
        <jszhang@kernel.org>, <wefu@redhat.com>, <wuwei2016@iscas.ac.cn>,
        <linux-arch@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-csky@vger.kernel.org>, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 03/17] riscv: Use Zicbop in arch_xchg when available
Message-ID: <20230915-banana-undusted-ec336f45bc78@wendy>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-4-guoren@kernel.org>
 <20230914-1ce4f391a14e56b456d88188@orel>
 <ZQQUQjOaAIc95GXP@redhat.com>
 <20230915-85238ac7734cf543bff3ddad@orel>
 <20230915-take-virus-1245c5dfed0a@wendy>
 <20230915-1c2b122672642e2cbcbaaaef@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RvlJFFFOtV+T3bcp"
Content-Disposition: inline
In-Reply-To: <20230915-1c2b122672642e2cbcbaaaef@orel>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--RvlJFFFOtV+T3bcp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > If this isn't being used in a similar manner, then the w has no reason
> > to be in the odd lowercase form.
>=20
> Other than to be consistent... However, the CBO_* instructions are not
> consistent with the rest of macros. If we don't need lowercase for any
> reason, then my preference would be to bite the bullet and change all the
> callsites of CBO_* macros and then introduce this new instruction as
> PREFETCH_W

Aye, I probably should've done it to begin with. Maybe there was some
other consideration at the time.

--RvlJFFFOtV+T3bcp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQRRUAAKCRB4tDGHoIJi
0j/VAP4uDnBGaw45oL54jYmlkjZdGwkSRY+9gy2iMWgBfZ9esAD/Re3zn3/oL7dh
xOW3yDdXSJA0KVeV1pIWZvJl+hJhIwE=
=qlmN
-----END PGP SIGNATURE-----

--RvlJFFFOtV+T3bcp--
