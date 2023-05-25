Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592E0710DE9
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 16:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241549AbjEYOCx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 10:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241521AbjEYOCn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 10:02:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8372D1A1;
        Thu, 25 May 2023 07:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685023335; x=1716559335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FLtz5z2b4ufY5t0xgFsw0GaGtQUkElO5inKmr9KYp8g=;
  b=NKQKVvnThjh91cqzhMi3k8wi/7avFhlD4M/8tyyOlJgabiot2PzRNf0q
   xLbXtqRzfGS7rH1ojG38CFTSM9xc1OREac+h44YqsfY62vO3V5CYBE8rg
   GVmyq0FTABVFh7p45A4FJpbQ9qnlCSPLjMTjsKc3yvPNuAL0aYcHKoMNB
   SkDXZfrhf16x4Msm6i//NyOpf313enZkop9gwk2/wRxAot57PYOVJ3frl
   fEf93AWDQRRa3elyWZ2+9uNOACGBv2xCbjA1FWoSwG98NzASFEQJVpTgx
   KXIqhgMoMiyl8LwIE0fopqLuk6crG0qLx2KvCj4qMrCsl1sfB7bGBbtai
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="asc'?scan'208";a="153916143"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2023 07:02:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 25 May 2023 07:02:00 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 25 May 2023 07:01:59 -0700
Date:   Thu, 25 May 2023 15:01:37 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jisheng Zhang <jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] riscv: move options to keep entries sorted
Message-ID: <20230525-helpless-rundown-47939298e75f@wendy>
References: <20230523165502.2592-1-jszhang@kernel.org>
 <20230523165502.2592-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0SxiKJNDT1DzhBlm"
Content-Disposition: inline
In-Reply-To: <20230523165502.2592-2-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--0SxiKJNDT1DzhBlm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 12:54:59AM +0800, Jisheng Zhang wrote:
> Recently, some commits break the entries order. Properly move their
> locations to keep entries sorted.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--0SxiKJNDT1DzhBlm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG9qQQAKCRB4tDGHoIJi
0m+fAQDhxk9pYPQ9CMmp4SnJa1pOHiM29+sqXxmtN1nOODe35gEA261Bp8FpQngP
XAxfBzQVFHzicU96pieUwmGOnyFNNAI=
=wtvX
-----END PGP SIGNATURE-----

--0SxiKJNDT1DzhBlm--
