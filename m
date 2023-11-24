Return-Path: <linux-arch+bounces-439-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E10E7F756D
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 14:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAF84B2138F
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 13:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1C0286B9;
	Fri, 24 Nov 2023 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CvwedB4s"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C945D71;
	Fri, 24 Nov 2023 05:45:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCnajuDRMbH2tbXDXesXM/khYQ9978dEt+7rbZhJe6WXb+/N9ugsn1+THF1DWbhkp5AiVjywB4iiFRkFGFgX4vWWkQf1TIEhglashtPwk8QvqffFNrCk3oQgwXYI7Z38kGRzLgl8mGRftFjlWIxkGU6MwGe6DLUXYlzpj2tL3wLZKvI8Os03eTXWT20mckYoo1pwUG7Wk45KLFpy9HFZ7zS9pRprIfi9EEVG0hKKnASi+OAzpnJMrd4of2jxMRcY0IpqwQF3+1dDwZwfGvGYcc6Zev/tTWD3jeDOqlyeBJUZxlyL5DZIQ4aSO7QVAIWryPF74ni+nktgJ+kRG6zsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIixSM1oafb2L/0ALvHTGgdDxQldAG1qgckIqoyZapE=;
 b=Bq02B1LxAQM2jpWxdB5bYyC2WobGX+r4RqcDUmaqObEvyhjAwz9bjv9RrYsq9o3l61qe7Lgr5cpQ2k1YaQrDKLILFV9M8xFiPfk6RTW7U8hZBppJNvzWnzfBTmRDm/enVG47X95hV7wDzaTPGnxV7wZr4LNpLVcK1Z7k/T+37ADagoobpdmKLEW/lRCQlsOYxAK0LI7AxRScYW6yK6tsUh73NUwxjcmVrttBejpAWywHae73AVFGlEszh2wdt4raVawjmbO+OHS0jV8at/4ytPH/4xT27zefBxtxwELk7cqHLXk/uAb5BS8VjAQzY5D4cDaLFsRDDu3deF0hlsh1uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIixSM1oafb2L/0ALvHTGgdDxQldAG1qgckIqoyZapE=;
 b=CvwedB4s3aNPvkg5Yr0b1776uKDWLwJCpBbMCWynPCqVBSOtYPUHI8FLc7qPnIawB9KVmbwJGQby3BDlhGOeESZuaTqSYHI4YS8JILgb6Gz0jlTT1EH8//JOZRZvcv5jVsiCBQY8CPJYWr8pg59IR6XtxVW0m7kvne9wo2J0kudPIQOaaXZjgKaYGzsQjlrbaRBzpCGf7sfwEb9kLyU6pXvq8+SCckpO25L0kzWgWmEEBmdiRXi2Je3g3OOZqZvnrbQVWV977RUhWtamhAQSuDuaXJ8RCN6J73shH8klNnqgKDy7YGxl2mxhN4DCue4zw6wEWoEjoKKiaOymiu0EWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6477.namprd12.prod.outlook.com (2603:10b6:930:36::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 13:45:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 13:45:02 +0000
Date: Fri, 24 Nov 2023 09:45:01 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Michael Guralnik <michaelgur@mellanox.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH rdma-next 1/2] arm64/io: add memcpy_toio_64
Message-ID: <20231124134501.GD436702@nvidia.com>
References: <cover.1700766072.git.leon@kernel.org>
 <c3ae87aea7660c3d266905c19d10d8de0f9fb779.1700766072.git.leon@kernel.org>
 <2fccdb30-aad0-4334-89d1-d4c86d17c9fc@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fccdb30-aad0-4334-89d1-d4c86d17c9fc@arm.com>
X-ClientProxiedBy: DM6PR11CA0063.namprd11.prod.outlook.com
 (2603:10b6:5:14c::40) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: f206b94b-1d8b-41ab-ccc7-08dbecf38ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tOqX79OCp+bNw+w0z3m86W+2GlATFt26kq5lO9JO72EFIBlXc2jad/I949Wci7zQ6/N9D2ZFU6a0yJdvKJoePO9ziAemFJVmqZhgvBqYreiELisI7SOVNCRXHxbrMERpAaXka0no+si611lEGhIa3imkmgmws8S4DeOSSOLIBQPPoh+6oLVoz/Q5uTHBsdmZwUVq7DW9fcPB7Z8BRoaMQb6enY+0815t5kl6v+HfQykc7WQs0JkKJkwQhVZiIA3tXdOZwTCBAQuYAJUz7aVUpgD/97aLj/WPPg1y09oqDDnksxFNTCFry6WjTpdd0GcG/zx++JFX3Dz338bayCfzVxBIElSNhccmXcTnUp35AgWIQW6qEFEBbPj2lEL7uUHsxO/eeTHOrb3SqxMWHQ+VsrwTe34LLVPGWllD8BhfdA2lLPorakg2x+divSSDz1rO3IKYfjwX2MUI0E0j75o2PCrF5Ajj7O2v7W8NLxcvqOtpiawEHzW627hkMeL8KbfB3AbUAMBbqda28//WlO+gcKhFNAV5u5XJ1Ipk1z9ehiq9zMuQvbGZaTapC2ifOceIikKXZ09nhtq1nz+4JjmogBkMEjee0MUQLlnw8g4SWvQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(136003)(366004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6916009)(66476007)(316002)(66556008)(54906003)(36756003)(83380400001)(6512007)(66946007)(26005)(2616005)(6506007)(478600001)(38100700002)(33656002)(86362001)(6486002)(1076003)(2906002)(7416002)(5660300002)(8676002)(8936002)(41300700001)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zsJPmSKga3ocnJyLw0vZBZVh3hAGkHJ+S4RxQViNm0qGwSeRO7JFgEtIkeCJ?=
 =?us-ascii?Q?tREl7YK+ot4hFSTmb/Gr9sx7TlGTTd31huOpau3YoETELNPPB+g+bgvMsJPj?=
 =?us-ascii?Q?gGkX5m1gWjHPfft95vxeymAUZmRVhQ5NPoF3bV7L2+RSADeEkkW+oQhjwIj+?=
 =?us-ascii?Q?Ed18/IM5EOCBthEJKhbrpJPPbGYQ+u0INWRjzumG5HizJGLTMZbmwxlwC+rQ?=
 =?us-ascii?Q?GHrqpQ6HMOrBmTqhR72Drs3psGlc/oZ0qRBc3X2lBczOVDgwcxMkeYXiB4xp?=
 =?us-ascii?Q?My2LjBCh4GcHTGuqL6hZ1kFgCLrSNQn/96FcsMJlxWBryuxXoWHh2uNGH55a?=
 =?us-ascii?Q?pSsDH+QIZpYkhy6yfnaCf5HFSUXcqM6hTUSw/St0rMnBBbKR2nisdsurVw5B?=
 =?us-ascii?Q?kxP9p+PziP9HSMOFRHGvt+Z4Twi+R37gAL4JgYFiB3Iy13Z7vrUQD25Sx6q4?=
 =?us-ascii?Q?/UiNqE0gGNI5FFN5xAeLvpekGHw7xYpugu9ro0JnV38M6TzbWFCeybk2iMkl?=
 =?us-ascii?Q?ctT5IEwtGE9lwJiuWmK935ogWOpm913LYQHDL4CsEjtQaDH1Hsidf6YZNRui?=
 =?us-ascii?Q?NV1Jeshsyv29A5Fft5OXXqd0VAjFNdsFJYaNV9fHVWWzrdzq8kIMLyD381Cs?=
 =?us-ascii?Q?1iqotWe4CE7JQF+07SAtHFd2uhI0Hm/tz89HmLIu9u8dStjnc3pNQ+nFnAOD?=
 =?us-ascii?Q?S+r5P1So32XekKZeM+Lfc8GL+cTmN6SYU1E75SvxM6Iz+s9AKk3f33spzJEv?=
 =?us-ascii?Q?zJOcapyx0wcA5KEPba8OzG3B7MOfzHTNDZ4sND2Xwk1rwTbtxzv3mLnEtrYr?=
 =?us-ascii?Q?/0c6uMmFMszx/UlKc21WPucyYCE9Zxc18N5uiUBchl3tPozjHv7aKL8NUDI3?=
 =?us-ascii?Q?QP9yyIOgfskyVhRKmwgGoK0JqfXkOntwnCHIrWJna8z0/U/QLCAEoZwFwlL5?=
 =?us-ascii?Q?LiIVcoete3KadgczNB6uZxI1VjHzVJxSSVScz4+e73N5T02YpCC+vte083y4?=
 =?us-ascii?Q?xfw+Iv4eGhd3JA7TDZGWvNNrEO4qTMvtU7WTlsYs8uwqfI6KS4Jshl4JfL2p?=
 =?us-ascii?Q?mgr+FrKEFWNR0x9+TLCyaP9COFM+jU/OI5nVnpEXIhcM4Nx34h05+0erYxYV?=
 =?us-ascii?Q?rKSgVmpv6gGr7atOHj/E3LEWyFOR/Q7w3IEcOlqhqLLMhcMq+IMXzmbxMCBS?=
 =?us-ascii?Q?YL5ahRiUTJes4HkUKzbZwsSZ3YuavTWqTfgSDpalWN6r/Eqxr0I3SjldC3ED?=
 =?us-ascii?Q?0f9Z3aQ8b4YvgJBodPeLkJhR6qYRPOKjsYRi5/EohG7MgFB7RKpYJ2cEXPQP?=
 =?us-ascii?Q?TxZZJmzZr5psA9DeZltPL8Z+539D5Ak/o1Ih10tN8GI2r2vG9pVLSiHbhi04?=
 =?us-ascii?Q?rDxGvsEOUKNIysrM9dasVcV62i3DW1J8o0/cJfQnasoXdyVADP2kbIuiTB1P?=
 =?us-ascii?Q?eB10FOasbHp9XaJ8iM4PasvKRvHi0ozLUrEVMBazqwshrVv4+fZwcIqd2H6a?=
 =?us-ascii?Q?KN/RKj3F7LVP3Mb9tKqhPERbrlCRIGtOKJEKY5SX7gQUHRLIF5CjdD/PBmol?=
 =?us-ascii?Q?EL+xUBuOoHfhYsljVm+HhaSdBORF/xmRsDv+D0+1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f206b94b-1d8b-41ab-ccc7-08dbecf38ee5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 13:45:02.3156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EprX22nAPmejkcRRzpyWrnb1SebESfGJarJ1WRaN4/jDlNP1F/awJvNigXHVjVKZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6477

On Fri, Nov 24, 2023 at 12:58:11PM +0000, Robin Murphy wrote:
> > diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> > index 3b694511b98f..73ab91913790 100644
> > --- a/arch/arm64/include/asm/io.h
> > +++ b/arch/arm64/include/asm/io.h
> > @@ -135,6 +135,26 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
> >   #define memcpy_fromio(a,c,l)	__memcpy_fromio((a),(c),(l))
> >   #define memcpy_toio(c,a,l)	__memcpy_toio((c),(a),(l))
> > +static inline void __memcpy_toio_64(volatile void __iomem *to, const void *from)
> > +{
> > +	const u64 *from64 = from;
> > +
> > +	/*
> > +	 * Newer ARM core have sensitive write combining buffers, it is
> > +	 * important that the stores be contiguous blocks of store instructions.
> > +	 * Normal memcpy does not work reliably.
> > +	 */
> > +	asm volatile("stp %x0, %x1, [%8, #16 * 0]\n"
> > +		     "stp %x2, %x3, [%8, #16 * 1]\n"
> > +		     "stp %x4, %x5, [%8, #16 * 2]\n"
> > +		     "stp %x6, %x7, [%8, #16 * 3]\n"
> > +		     :
> > +		     : "rZ"(from64[0]), "rZ"(from64[1]), "rZ"(from64[2]),
> > +		       "rZ"(from64[3]), "rZ"(from64[4]), "rZ"(from64[5]),
> > +		       "rZ"(from64[6]), "rZ"(from64[7]), "r"(to));
> 
> Is this correct for big-endian? LDP/STP are kinda tricksy in that regard.

Uh.. I didn't think about it at all..

By no means do I have any skill reading the ARM documents, but I think
it is OK, it says:

Mem[address, dbytes, AccType_NORMAL] = data1;
Mem[address+dbytes, dbytes, AccType_NORMAL] = data2;

So I understand that as

Mem[%8, #16 * 0, 8, AccType_NORMAL] = from64[0]
Mem[%8, #16 * 0 + 1 , 8, AccType_NORMAL] = from64[1]
Mem[%8, #16 * 1, 8, AccType_NORMAL] = from64[2]
Mem[%8, #16 * 1 + 1, 8, AccType_NORMAL] = from64[3]
..

Which is the same on BE/LE?

But I don't know the pitfall to watch for here. This is memcpy so we
don't have to swap, the order of the bits in the register doesn't
matter.

Thanks,
Jason

