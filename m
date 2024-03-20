Return-Path: <linux-arch+bounces-3047-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935FC880A63
	for <lists+linux-arch@lfdr.de>; Wed, 20 Mar 2024 05:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8F3283897
	for <lists+linux-arch@lfdr.de>; Wed, 20 Mar 2024 04:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE98125AC;
	Wed, 20 Mar 2024 04:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="W1TmzBhz"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2116.outbound.protection.outlook.com [40.107.220.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE97846D;
	Wed, 20 Mar 2024 04:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710909588; cv=fail; b=t8340w3L5Q7nyweDZj0ilMm6yXZYo+l8SNWtjtPAuiv3PAbsrkFg4qInJhdZUx/E2IWlklJTK+jCqt0AXcneh3RHdUsnL2XlYt9MrY2PlJl1FPn2laHIGPDgu3T2PEW0oSmCUGTJUGtC/qjHhI0P2tbnwxyr3NSbXRKZVTDSJ4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710909588; c=relaxed/simple;
	bh=uFgEgkVL+aYSPxFHTVrxkvteEMYj3d5M6g10WPeU5Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PG5i4VN1SGhCbcUerw1QjFGpkcLDrqtKUq4wodzcMyu4g+ZhR5QJm/u+uNQfsr4rn8AaCiIChywgRdUgiABelLPKLTR5hXsSWrfO9hwi8Kt5omghEu8f8M9ltHmvJ5vao3Dhl2MeNgBUIngCJ3czP0qzXZnqtp5eav3NCvTuZ28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=W1TmzBhz; arc=fail smtp.client-ip=40.107.220.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZYS95MrkNVHENNf5PBDd90HuIK6bHQRVZFmtdWfgkB+aEIGNU4GGEeru2K+NVOEExLBkJYz3RQcUxwBhgXloGMeRxKez6bbw/4VADDevF72CB6oT1wnhVzUyZeSgsI/VcXq+7zAWcEF1VyomzXqQBT1b0/X9ezRfHVRuLCYinuxNuDCJ35CuiLz6bWySIB6mx8fpGlbhF6/bgRe7ipRRbbxh/glqri/nKk1QHgzB1316wn2fCr1HTzJYtteptmFcKQLCWMekQQu8wjHI3NV5Y/Lm/y95F5j3YRi4VQZumdY+fZ+rbucIA4FYUo7PcDbmA/yAVEqf/PJa6S1v0A9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjT6yKaI+naNSBoHcSjiShYf8qPvy3PkMr+TKm3am2Y=;
 b=YF8AgdU5TMOTNQrz9sH+huodTRqWBp8rm41+ncnrZmCI9JcdrgkmkO9YMVdMTpuUV6JpWS4M8KT9y9S//qWLuw+a4X+rpxdaq5aYMh/5+pfrMtRJlBXLpvADhGDwO1h3BSqSM7be13lbl+xdD8zgzvX6p/+jUyhRKwFre9b3vXXXbd/1EaPcI/qolXWHw6xrcEXP0I3xsIcwFcVDrLcLY59EVgmKXeyCKDP5ewsL5mmOaoioQ6XFC4lTIgRdkc6xr+dfUk59YVrF/t+dRWwsToVPj/IRpb7x3EJypAxno+wg8WFxiGHodqLwqaS0PLHJz0eI0WZj3hULWGUAkiowpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjT6yKaI+naNSBoHcSjiShYf8qPvy3PkMr+TKm3am2Y=;
 b=W1TmzBhzHQ1bk9MpNvFTRALDFVNOG8+KSJ0PiWciqyf3vPaMHyvowYTv3/WZHi9k9SjDh9UO6X1WmrgTSTCnYQRkgn0mxIQ8UWuKphEYjkfAn5ZNwNKPbChkFAX316luLqkpHkKz4TDzwi4y6Hn1QKgUMxvniV9XJJGiDONILRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW3PR17MB4201.namprd17.prod.outlook.com (2603:10b6:303:44::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 04:39:43 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b%5]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 04:39:43 +0000
Date: Wed, 20 Mar 2024 00:39:34 -0400
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com, honggyu.kim@sk.com, corbet@lwn.net,
	arnd@arndb.de, luto@kernel.org, akpm@linux-foundation.org,
	shuah@kernel.org
Subject: Re: [RFC v3 0/3] move_phys_pages syscall - migrate page contents
 given
Message-ID: <Zfpohg3EGxxOEcWg@memverge.com>
References: <20240319172609.332900-1-gregory.price@memverge.com>
 <87v85hsjn7.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v85hsjn7.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR05CA0142.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::27) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW3PR17MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: c5be5050-a02e-4e1d-070c-08dc4897c306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xWwBlQ2kj6+7ToBxiG3uuAzx5nSmwo6SlG4X/6LLdaC0RaLkvGo/4kQWsjEd4bKzHOS0zQNGE2wN44Ftp3x89ZDM9nKFhFJGNq7sb1Ni++BZzMnkRgdH6VbLMxSLtNd/61EHJllRMm6FA1SDpPAP/GLj3ikAiDR3E5eUMduIm01wZ7JhE4uEsUT/v3Ve+2d7pxOgfy3kti+lfrXV1k8ogq0KBvhOzoHB3N/QjfzuIPhS2HeQ2x2jbufVB7ewcwioCaQQLCg5eLhRN0aBPYapE64n0BzH7nlRlb3cGllN2hYawAMSo11oDa3XU28DInwCF/vNXdH4PDg9ihTzBFyM1IZhHwaZFnDIyjW9u85koZLCA2gQgO7uUaCR/XyxHnhUrfOBcmr8nweszuKqRZtNXjJ1H3B7mf8VpXp78qXBXULUFvCPi/AzGRIIJmsytGYTGbvVfOu0VTY0T/oMTLu0WonAN6nAtRtOduDDujs/68nEdibGgBYDZiB/Mq44objGxovShdlrBpOImUYtNSsxl79u8ov4eQ8WkdRtHkTziaFTlufuX/cCHxOh5ZQCHlEo+IOgxk1nmUxtmIIxzRTi/R77BgnIZAlL/oR2UcXj2+xHiGfF9W9AdQXCAKpMhWF7pqjJNRd4x575CeTZlZO+j73X0F5rS2Xh4kl+Q43D4O8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xyptoRBv+AO6Pa8tmCxyiw60L7kt6GkKNCzS/MbQFsGRvdWQjXKGUHMQYq2B?=
 =?us-ascii?Q?38+edWjd+2W40otCn80lcy2G2A761ab6PwD2BvEAXm6sBakGOPSgmW5VliAo?=
 =?us-ascii?Q?tUnUiqIh8kmjbMO8481Lgsk0abniMXzdkjRsWvYlXKcIGaLdi30HqTtvUJh6?=
 =?us-ascii?Q?gn8cv7Z/bMA7iklfmVCi6D3GYCAOBAMBR1Ssg5xF4+IEv6R0RisXgiiRTb1F?=
 =?us-ascii?Q?lXibAABWMJQNkOYySX80RNNHKYNOGaaz0qxtZXKv6PonYzC84yEdMVFZy1Ys?=
 =?us-ascii?Q?VzOV5Ks1VKP3tU4zKQz60J8IweHVN+OUZvhKSWvUWrVa/2mhF3qinF9WVMu7?=
 =?us-ascii?Q?7Mxotii8jgZNM6Uy/ZPtRi61DivW9nm3suP9BnqnNT03GggeNU5USRpxj26G?=
 =?us-ascii?Q?q3moUcVJckZML+gPwqlvoBCX4Hs9eBeiF16ouMI1yxBqdtiz3CHtv2Xj4ArZ?=
 =?us-ascii?Q?O4ijTbA66dWU4HpXZanfZ7XgjF4JTcG54j9dYnZFaWeBl9NVXIlnuYUBtT3k?=
 =?us-ascii?Q?u4PBLx2xsIFdQIRJPM1SlgCu1hrI+XOypL17id3Hclg7j0WDeWXcw/vN/rnz?=
 =?us-ascii?Q?jYijcJ0EHdCbbPHZLDeOiG9jUydNowkQEqBTrVDTW1uweezrx+/yEkpmaP+j?=
 =?us-ascii?Q?VSQpdjH42TtfSWL1JDGIZjSpCzQjtZW/ylnCOmXQoDuOulXaxIjQsqqQycbo?=
 =?us-ascii?Q?D1zoZuGnC3jYqedy2gNBx41uPe9lJgicxC52q3CnkSVXvdSAwfmuyhr/xEbT?=
 =?us-ascii?Q?dgeoWO4OHmbD1adnNqLBHA7E4l49PiHzjaoZTqiBWiXdDhsHiEn/Cj3PU0NW?=
 =?us-ascii?Q?1eL7aLj//ZK1HLZCgu6zKJ3igq0qqPK7KYLId4e1lDeFT+ccUZTiaYrkzEhg?=
 =?us-ascii?Q?ect/pdNk0J+iN/M+QFbOtX+X+5lhduhkj6ibIOk8rx7TtDjC73SaEtBSuaXi?=
 =?us-ascii?Q?6OtyC041jEViwKdtT5y1h5EEUj0xHl6EBb91jUK4mdYRygOa3autSUs8gBkj?=
 =?us-ascii?Q?q2ThzvPVR5UDuHbEteQClWbQ6yjJwuCb0aIXhlfatDj35Snkqo5LiWqyXSh4?=
 =?us-ascii?Q?/3mG/0rbH9qfZoSKy4TiIeqcl7NxbNk1TNK+Qs0o8dlVbCI79K3+HiUH8X70?=
 =?us-ascii?Q?JzKETs40W0f0RIV5SEN3++QFWhuF8QzwdlvZIn2u2nI2fhw7gUp+j5ZjKbLy?=
 =?us-ascii?Q?fZ7RpkvGZs1idq795QKrtpLGMxv2cU/ki82oaobgyWIYwsxbi35P9LH46rS6?=
 =?us-ascii?Q?G2U/SoXJhBzvDli/S2i4SqlQ5x6G69CjMLlZBW+wQVKujnAAGBOvt0AOVaci?=
 =?us-ascii?Q?NStI4J68oGlG+41luefZepzWn/evF7Uk3mEuKiMbJCxQOPVsOEJ4MLQalJ0l?=
 =?us-ascii?Q?hNNn4JCvhuhLI7obiindiZE4/J9XgLBUXNmHY6w+DAV4DUOKOIzkYyaQfdwf?=
 =?us-ascii?Q?zAL4jH7dF6PP0ujzOIW4cvEtWUGw8fSoh+fDiBQ0XF0VSFwTmFhqnilPpxoc?=
 =?us-ascii?Q?eJ2e3L8lgQvIa0nYDaLyGqZddlxWwN2+mtn9r4MmfVlFqkOdQzYM/++S4adn?=
 =?us-ascii?Q?ZPnVUZQxDuCeFTvavSp4FTO3xdhsulpf90hYTJqHFUJMz7ntZYCPHNVum8kC?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5be5050-a02e-4e1d-070c-08dc4897c306
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 04:39:43.0732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6D9eP/ToaZQ49E0B4SjCbS9x7nVltHt9Bv/5PW63YUltpQl1OCsg8GYcaMfnWpJc1WeTitYlT/QVoxp8+5XXkeVvfuJsoTbQvLmomtE/Sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR17MB4201

On Wed, Mar 20, 2024 at 10:48:44AM +0800, Huang, Ying wrote:
> Gregory Price <gourry.memverge@gmail.com> writes:
> 
> > Doing this reverse-translation outside of the kernel requires considerable
> > space and compute, and it will have to be performed again by the existing
> > system calls.  Much of this work can be avoided if the pages can be
> > migrated directly with physical memory addressing.
> 
> One difficulty of the idea of the physical address is that we lacks some
> user space specified policy information to make decision.  For example,
> users may want to pin some pages in DRAM to improve latency, or pin some
> pages in CXL memory to do some best effort work.  To make the correct
> decision, we need PID and virtual address.
> 

I think of this as a second or third order problem.  The core problem
right now isn't the practicality of how userland would actually use this
interface - the core problem is whether the data generated by offloaded
monitoring is even worth collecting and operating on in the first place.  

So this is a quick hack to do some research about whether it's even
worth developing the whole abstraction described by Willy.

This is why it's labeled RFC.  I upped a v3 because I know of two groups
actively looking at using it for research, and because the folio updates
broke the old version.  It's also easier for me to engage through the
list than via private channels for this particular work.


Do I suggest we merge this interface as-is? No, too many concerns about
side channels.  However, it's a clean reuse of move_pages code to
bootstrap the investigation, and it at least gets the gears turning.

Example notes from a sidebar earlier today:

* An interesting proposal from Dan Williams would be to provide some
  sort of `/sys/.../memory_tiering/tierN/promote_hot` interface, with
  a callback mechanism into the relevant hardware drivers that allows
  for this to be abstracted.  This could be done on some interval and
  some threshhold (# pages, hotness threshhold, etc).


The code to execute promotions ends up looking like what I have now

1) Validate the page is elgibile to be promoted by walking the vmas
2) invoking the existing move_pages code

The above idea can be implemented trivially in userland without
having to plumb through a whole brand new callback system.


Sometimes you have to post stupid ideas to get to the good ones :]

~Gregory

