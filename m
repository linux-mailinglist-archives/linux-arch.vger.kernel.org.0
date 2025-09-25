Return-Path: <linux-arch+bounces-13777-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD01BA0A60
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 18:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D27A56334D
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 16:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D837307AEA;
	Thu, 25 Sep 2025 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sLy+XqpG"
X-Original-To: linux-arch@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011039.outbound.protection.outlook.com [40.93.194.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3D0307AE3;
	Thu, 25 Sep 2025 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818282; cv=fail; b=GnWUvJR2CgxmisqpTHkFYihFEQbZHP49Uj3Vb2UNItKfV1b+0o2Vh0Ycrd9cFopRpcFqJfvBVlbnH8CZnltK2V33OaIYZ4niJ+1OwXJ5b2DwCAliDhfNvp7bwU/mkY2Yj2Ob2348GEZEKfijJSaxCS/2ghdR05fIDMrpYuejkkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818282; c=relaxed/simple;
	bh=5f9+lEp9lUYJdLZivmQhnr34yVHMiPFmB0SCpYKfzj4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r7kUoH93fQNV/qc85FubSMmrWPKIcPVpy5g0uKDZbMuSlRd+DRWSK7cUGx5V0kSJEYU/q632PSjDI/+HC2MWJvzMgPkNDgPCQOfDZF0wqt5QUr8dkiSojJiLH/IdECzunX8v1ToVpDPbHufkqGJo+L1358pN8dAJGgAiQjaJ9LQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sLy+XqpG; arc=fail smtp.client-ip=40.93.194.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suJuiL2XZIGtwuMOX8GR1AnC8B8Rk0cv9eP2zcNUxNSx38atuxGNB1CAY8L0iaKlVvvgDyURoU7gXtgnLat+Pj90KpAMWBlaSLz7ApFqBINP/4u0NcluugUu9rr9P64JycEQmHkFXWMe4scP+s46U0Ic+RDb9a+5pqWoX/IH60NKfhdwZJrid73zy3sfCWQuJ0trfpo3ZG0waVkgwDAAeA7YwfDcO6g//FUF8nvxdMelH5cRkDGyAQs/sDHq+j5x9AgJvspthmPRBkMlWS03kSvpRKj2oNNGxtHob6+btHwriIA/zYqOt2XgNEY2jExnTx1md3d61+A2nZ2BVQkBPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5f9+lEp9lUYJdLZivmQhnr34yVHMiPFmB0SCpYKfzj4=;
 b=LcEEgga0ULz/yUtykb447bL3yM6Eb4PzODXfox+0C5YBK9sj6kOI+TO7NCdrPU6TAtYtzk2qZabLMkr0eYVnHKiV+OkfS/+rrbdxbvVcNNYzRxGL9cX3KG23H/ad8B2LZu9ayM/HsTJE7YB+4cffb0SpoWhAB0R8HYMA5P98RfSw5E9qNwU9QKzojG8krh0lNzo3ckDUjzJLWVu56u7PCzf98TVV3682+Ay9wGNpxcNnQWNXzdS9qr2/xi4jYeRKoRJlF7KcY5DV2tgYFhXnikaD2xQhoQhO2gc17gMZ00vRWeJ/6FitpZQft/zGkJ2tfvJEyS7MaVNv4upi0M4hNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5f9+lEp9lUYJdLZivmQhnr34yVHMiPFmB0SCpYKfzj4=;
 b=sLy+XqpGJL1ZPtgTYnX4ax+D7cl0JdXJ2CpzkOKrMld1CDRyMv+yz5IGV/ng5li+1Y6+SePpPGS6y0uN1/OFHHhFVxH8cG0n0NRj8xateRU0+W4i8/n3zv6QAe1bgpXu+PTR+6eklUgd1WAO8FsCtGaQ+8fOWIHuhE+6JjUpjH4=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 PH7PR12MB9074.namprd12.prod.outlook.com (2603:10b6:510:2f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 16:37:55 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 16:37:55 +0000
From: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To: Arnd Bergmann <arnd@arndb.de>, "git (AMD-Xilinx)" <git@amd.com>, "Simek,
 Michal" <michal.simek@amd.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Frank Li <Frank.Li@nxp.com>, Rob Herring
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, =?iso-8859-2?Q?Przemys=B3aw_Gaj?= <pgaj@cadence.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"tommaso.merciai.xr@bp.renesas.com" <tommaso.merciai.xr@bp.renesas.com>,
	"quic_msavaliy@quicinc.com" <quic_msavaliy@quicinc.com>, "S-k, Shyam-sundar"
	<Shyam-sundar.S-k@amd.com>, Sakari Ailus <sakari.ailus@linux.intel.com>,
	"'billy_tsai@aspeedtech.com'" <billy_tsai@aspeedtech.com>, Kees Cook
	<kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Jarkko
 Nikula <jarkko.nikula@linux.intel.com>, Jorge Marques
	<jorge.marques@analog.com>, "linux-i3c@lists.infradead.org"
	<linux-i3c@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
CC: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, "Goud, Srinivas"
	<srinivas.goud@amd.com>, "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
	"manion05gk@gmail.com" <manion05gk@gmail.com>
Subject: RE: [PATCH V7 3/4] i3c: master: Add endianness support for
 i3c_readl_fifo() and i3c_writel_fifo()
Thread-Topic: [PATCH V7 3/4] i3c: master: Add endianness support for
 i3c_readl_fifo() and i3c_writel_fifo()
Thread-Index:
 AQHcLKFhrxQvMAo9OkSHor4BRo6l1bShHNCAgADPJECAAC7KAIAAJThQgAAfVACAABEjwIAACgMAgAEkxmCAADN1gIAAR8EQ
Date: Thu, 25 Sep 2025 16:37:54 +0000
Message-ID:
 <DM4PR12MB610946C438F742BA743A0BDA8C1FA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250923154551.2112388-1-manikanta.guntupalli@amd.com>
 <20250923154551.2112388-4-manikanta.guntupalli@amd.com>
 <13bbd85e-48d2-4163-b9f1-2a2a870d4322@app.fastmail.com>
 <DM4PR12MB61098EA538FCB7CED2E5C47B8C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <4199b1ca-c1c7-41ef-b053-415f0cd80468@app.fastmail.com>
 <DM4PR12MB6109E009DAC953525093FE808C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <134c3a96-4023-47ab-8aa9-fd6ab75e5654@app.fastmail.com>
 <DM4PR12MB610989A03A7560F2A03792838C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <295ee05e-3366-4846-9c8b-85ac09d79d48@app.fastmail.com>
 <DM4PR12MB61090F307DBA2B99AFC93B168C1FA@DM4PR12MB6109.namprd12.prod.outlook.com>
 <b2ce3e0b-a639-4e70-a5e7-ffbdc855153e@app.fastmail.com>
In-Reply-To: <b2ce3e0b-a639-4e70-a5e7-ffbdc855153e@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-25T16:31:41.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|PH7PR12MB9074:EE_
x-ms-office365-filtering-correlation-id: 49f1c009-ebe0-4559-cac6-08ddfc51e0ca
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?tScMJWhBtzh2UJP6LryOl+Hz+XkdI5oobrNbmDN/QPxHER+/DSQPtLE1Ej?=
 =?iso-8859-2?Q?c4tiNUnl675YGIGLzOxSmLpepDArJ56CsUHXsityMk1/LXGeFOh/lcQLwL?=
 =?iso-8859-2?Q?kfvkN9sEyZEaPkYBqGj1qh92P8K88KdUTamcca+NoxMP7ASVw/z3vJ/RtO?=
 =?iso-8859-2?Q?RkLnXNkDEGN6ibB2tlP5zDDRwdvpxuTY8p8cw8TeG9UkBV/+R7l858Iq5y?=
 =?iso-8859-2?Q?7URnD9cSh6sil1Jzb2UulegdqX4PLgiExgeaDpiQ4Ynj9cEXkwzJmxruGL?=
 =?iso-8859-2?Q?8Qoi8o1jMroT8bAUWv35UjOnGWCYZ5ceAz1muEJal00y2BW+ShDRWglw6k?=
 =?iso-8859-2?Q?N8gxxOtl4VgAmmFYtixq9rLRWTY89FPBibJLQpLQsvYlOemOiOWZV8dedU?=
 =?iso-8859-2?Q?5IG7IyED2qjXihI3tXqDrDUzXqpTDrZ9IpL9nnkvXcwXagkVa2dYv//6g3?=
 =?iso-8859-2?Q?F1XnqZNaw2uD4r/zZVG59GDrkLzf1Z4rnUBPzwiw4dr81XNK6rt7AdBbiF?=
 =?iso-8859-2?Q?eGI3QFokKBmCh9XsqFJ0OGXLVWSDy55B8y3+I6P+pWdcwXpQx8Qw3GYILn?=
 =?iso-8859-2?Q?4sTSxC7eeC2v8DImfRDfr31PkzmwmcPO9TRyo/3lkbwxGt8ZRfLVayCIAm?=
 =?iso-8859-2?Q?Mdl554I7wcyJKPM4BEYlXivkj+Os9mZYVc9nQx9yyep447QpAUNa7N9ANh?=
 =?iso-8859-2?Q?ageL8wt6HZK0HVTGVcmaD1h4XJm+90yuqPbKef/Ues9BMoUSZWvf0eAx9B?=
 =?iso-8859-2?Q?JY5IskUtwDPTDHCajTH+oCPj1OxnNKk9Gjq5xKt9556DtLLtPMIy1Z7shS?=
 =?iso-8859-2?Q?a5s10u/y42X4eCdQq7J8n/Ywy4c4WBRJlklPx0aA2wV6StC4mfmlg01ELg?=
 =?iso-8859-2?Q?uKODPFbIx4Cm+aQFj8kWlU+KfsGAi00j3ZV9Wu03Ey759jgI/usTlQvoyz?=
 =?iso-8859-2?Q?uXy0hgXNb7zFcOUxYmwowPm7f/TXuwpW9uo5lFb7qQ3iCqupqlLfiFJd0D?=
 =?iso-8859-2?Q?IGMh7cpu/WbRGN0dlFzPH95k+Xsv13QoLgDbLbuW6cOXE3+3FttNSGc+xa?=
 =?iso-8859-2?Q?/PufuOisbRrwi5GXRY14Iawej+8HE87Z5P+ENI/Hp+miVLxtVejmxzCjVy?=
 =?iso-8859-2?Q?5xCjQV7KUTZ4x9YTPJS3IodYG26c+JCVZtXJ8UzIDxGvj4xfLqlzM/YK77?=
 =?iso-8859-2?Q?Hxk6T2RLeYj5ZAAWUc4sU6WA657SJs55AX7pmvk0sltz8ed5XQUOp7R6Wm?=
 =?iso-8859-2?Q?qawseDaLmg1wGe20QlT+8bg2XWifajqJiFdXDq2SvtgfP5yVKe8Azbnd33?=
 =?iso-8859-2?Q?dkJeCX5C4tYDoWD5YoO9zLpUkJqN0D3WgvvgICxAebU5LpQTuNaiExNQGn?=
 =?iso-8859-2?Q?7SbnZH8PN4Yux5vsIVj9IwcitUC8yBcjV8N0Y5xDqOBcR1rOmXUyYMRupj?=
 =?iso-8859-2?Q?Ulgm5J4fBejwU1OpBxpSu1JybabMlC1gNjWv8dIcwJ5hJUzUmvoJ1c7lhg?=
 =?iso-8859-2?Q?asJybaBBSTN240aIm0UJ4+dV3/VoTnNuv3xfasQF+cazGY6x7schRCRUvJ?=
 =?iso-8859-2?Q?fpLmhoYEhL8C8JWJAEFFRLViAOm3u8QrWc9Yy4HPu5MOsbJdqA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?jkvrdHR3X6Q+BnqiVgR7H/6KVAK1Bq35QuWrSq5j/F8z0omo3oJzkPjRGF?=
 =?iso-8859-2?Q?glDdOPxwnTSdopVa5IiH/kReAVJomVOywO1LB0QMe6kxZxY9aZIwFM+guf?=
 =?iso-8859-2?Q?ik+5WitRGqyw6siU9AKjoQ45YlldkLud3dTTbFMbOSwH0cLWlZwRVSahj+?=
 =?iso-8859-2?Q?648EGM/5Qce21nNfCJgGbXA6Q6shPrAdcCY+wTX4eu9yv94QuYO6QgRYrF?=
 =?iso-8859-2?Q?J2BWbZQol6HqhjuLCsitmzEWI/k4b22e/17I/Fm6wl/DZ4j8B3G6f9XiLv?=
 =?iso-8859-2?Q?I/YGJlZ2c4ojJY+/c9lkVvM5emYA4oEyioSnWJt7QHmzyFKOeYIza22p5I?=
 =?iso-8859-2?Q?hoU5yBHDTSw9Ck1oNH2bKlXeFqy+KtPL6kIBFWgqmCUDJyegV2Ub/kR0d1?=
 =?iso-8859-2?Q?/vhJbaBcyqPLs3K5TBltlH1IQIh5AExMrdfk0e592lGxMuo2LctaxIZPTu?=
 =?iso-8859-2?Q?sydWO2uDtjzve1YD2cT/wq/cyd65AvlX76aMEsTJeA5zAhBuH0TR8GmwOM?=
 =?iso-8859-2?Q?5BQJpioN+Bfe71X3IiUjPkTEAvSQCDO0ZSUap60PJLwEATobUERVa2Q3LB?=
 =?iso-8859-2?Q?9u+43Zw9viu+05UEjzwJZCDJhhoNdZaDE8tJRfOwvd6yUDTVU3XlvOfhE4?=
 =?iso-8859-2?Q?bZBSskmTuvg1iS+Xm4+nSolgaE83znkKTZJWN7Nbu8F8DHY6I67s+Qa3yj?=
 =?iso-8859-2?Q?9d/cHSDHFvOUt8or8MPHvhyjtYGQh57Usz7mTlcLJdNBdO0rV+e7BUkMfe?=
 =?iso-8859-2?Q?38jrx9lYn5IWHHMqRT6CMTQhi0n3VIed0i7QdenuisKGoU6e9vwSJrslww?=
 =?iso-8859-2?Q?Gzx3Y9bWDUQtIAm+ny3gjbH84lAPvaGQceW3JGWwjkbyprpeipt9ARnd4Y?=
 =?iso-8859-2?Q?/H6k7TuYYzptBafx/iI6gfgCa/rW6G41jveR9PpjTXvNhgMLczf8Em/39f?=
 =?iso-8859-2?Q?4wmW7nEs19tLtbt9zL7JZZ6UwZURy6Uy7yLD7mkE2T0WwLy3FIaURmawl4?=
 =?iso-8859-2?Q?kRiSe5VdjAX6cFbBo+BpxXB8SdTy3sBtgO7VXlXatqx5tepcSh21CgRej0?=
 =?iso-8859-2?Q?mLL7IB1Y+GtmA4pJgcIZ+I69vXv7/lcNnZjGdKvowkw3wtiSx75lXa+dWi?=
 =?iso-8859-2?Q?QwLHc8RU8An6Vp+6ZHKfC6SmpOaRzCASCgZgdRbHd2nohbWwkrpEH6qbx/?=
 =?iso-8859-2?Q?EmKIMVqSdDTI66PON9/nT2WXASA0lmP6QudRnDfo5UQCEGYP3lTqp5Nx7d?=
 =?iso-8859-2?Q?VwhZNP61lQrryeCiTnONYntA2pamDhuDTy6xUE6VV8FXj5RV6QalqBH37A?=
 =?iso-8859-2?Q?rbJVuiWvnv3N2udkOIpJW6Xdx8HAwoftlQJSp5csQW2TuqS/LgOS75YhXW?=
 =?iso-8859-2?Q?7Oqxpy6wz3TzHwhiypZ9ngTXSjQLDpNxT12Ighixtir5oPAQUSO2xaC6ig?=
 =?iso-8859-2?Q?BKwU37M5QLfDYaAEf2dDG6c1U9A/fcItTEaqWNRnQRhI3SFq00oyRV6Ovc?=
 =?iso-8859-2?Q?6Tv6wFsAn0okqIUt4ke7z/DyWUPRYrNj+YrM42Afhut5U5CQAt3HNNY2su?=
 =?iso-8859-2?Q?5EDgxR73qE/I2T8qgb/FFzaxOP1aG0PtuJ887+Fqg4j2YOVg9TewPzP7G2?=
 =?iso-8859-2?Q?tmPqqYv0G1NTE=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f1c009-ebe0-4559-cac6-08ddfc51e0ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 16:37:54.9998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qw8nGTgrniPmF3KCARQZaYBHu/ttO3M/Df3gb/tJZPQ/7cvZ5QVblxlJOTAUnj5/BLTaAr61poiVCkXmgUuPEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9074

[Public]

Hi,

> -----Original Message-----
> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Thursday, September 25, 2025 5:45 PM
> To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>; git (AMD-Xilinx=
)
> <git@amd.com>; Simek, Michal <michal.simek@amd.com>; Alexandre Belloni
> <alexandre.belloni@bootlin.com>; Frank Li <Frank.Li@nxp.com>; Rob Herring
> <robh@kernel.org>; krzk+dt@kernel.org; Conor Dooley <conor+dt@kernel.org>=
;
> Przemys=B3aw Gaj <pgaj@cadence.com>; Wolfram Sang <wsa+renesas@sang-
> engineering.com>; tommaso.merciai.xr@bp.renesas.com;
> quic_msavaliy@quicinc.com; S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>;
> Sakari Ailus <sakari.ailus@linux.intel.com>; 'billy_tsai@aspeedtech.com'
> <billy_tsai@aspeedtech.com>; Kees Cook <kees@kernel.org>; Gustavo A. R. S=
ilva
> <gustavoars@kernel.org>; Jarkko Nikula <jarkko.nikula@linux.intel.com>; J=
orge
> Marques <jorge.marques@analog.com>; linux-i3c@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Linux-Arch <lin=
ux-
> arch@vger.kernel.org>; linux-hardening@vger.kernel.org
> Cc: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Goud, Srinivas
> <srinivas.goud@amd.com>; Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>=
;
> manion05gk@gmail.com
> Subject: Re: [PATCH V7 3/4] i3c: master: Add endianness support for i3c_r=
eadl_fifo()
> and i3c_writel_fifo()
>
> On Thu, Sep 25, 2025, at 11:26, Guntupalli, Manikanta wrote:
>
> >> Can you explain how that works? What I see is that your
> >> readsl_be()/writesl_be() functions do a byteswap on every four bytes,
> >> so the bytestream that gets copied to/from the FIFO gets garbled, in
> >> particular the final
> >> (unaligned) bytes of the kernel buffer end up in the higher bytes of
> >> the FIFO register rather than the first bytes as they do on a big-endi=
an kernel.
> >>
> >> Are both the big-endian and little-endian kernels in your tests on
> >> microblaze, using the upstream version of asm/io.h? Is there a
> >> hardware byteswap between the CPU local bus and the i3c controller?
> >> If there is one, is it set the same way for both kernels?
> >>
> > To clarify, my testing was performed on the latest upstream kernel on
> > a
> > ZCU102 (Zynq UltraScale+ MPSoC, Cortex-A53, little-endian) with
> > big-endian FIFOs and no bus-level byteswap. For more details, please
> > refer to my reply in Re: [PATCH] [v2] i3c: fix big-endian FIFO
> > transfers.
>
> Ok, thanks fro the clarification. I got confused by your description ment=
ioning big-
> endian in [PATCH V7 3/4] and assumed this would be on a big-endian microb=
laze
> CPU, after I saw that the original i3c_readl_fifo() had a bug in that con=
figuration that
> your patch addressed and this being a driver for a xilinx design. That fi=
x just turned
> out unrelated to what you were actually trying to do ;-)
>
> > Please don't take this as negative or aggressive-my intention is
> > purely to learn and ensure it works correctly in all cases.
>
> No worries, I should not have jumped to conclusions myself based on what =
I saw in
> your implementation and assumed that fixing the one bug would address you=
r
> problem as well.
>
> I do understand that your driver clearly needs a special case, we just ne=
ed to come
> to a conclusion what exactly the hardware does and how to best deal with =
it. This is
> partly about whether you may be able to use an external DMA engine such a=
s
> xlnx,zynqmp-dma-1.0 or xlnx,zynqmp-dpdma, and whether that would need the
> same byteswap.
>
> If you already plan to add that support, you likely need to allocate a bo=
unce buffer
> and byteswap the data in place to have it copied in and out of the FIFO, =
and when
> you have that, you can use the regular i3c_readl_fifo() unchanged.
> If you are sure that the i3c controller is not going to be used with DMA,=
 or if the FIFO
> register as seen by the DMA master does not require a byteswap, having a =
local
> helper for the transfer is likely easier.
>
Thanks for understanding.

The I3C controller is not going to be used with DMA in our case.

We had initially implemented local helpers, but based on Frank Li's suggest=
ion, we added the support in i3c_readl_fifo() and i3c_writel_fifo() to make=
 it more generic and beneficial for others as well. That's why we included =
it here.

Thanks,
Manikanta.

